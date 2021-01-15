% New version of Free vortex wake to better handle multiple bodies and have
% less reliance on a priori quantities like number of panels

% Useful Rotation Function
rotZ = @(theta) [cos(theta) -sin(theta) 0;
    sin(theta) cos(theta) 0;
    0 0 1];

rho = 1.225; % air density kg/m^3

% Create initial setup
b = 2; % wingspan (m)
chord = @(y) .1*ones(size(y)); % chord as a function of span location (m)

n = 21; % number of wing segments,shedding and calculation happens at the divisions
m = 20; % number of filament divisions

U = [-1,0,0]'; % Free stream velocity vector, m/s
Umag = norm(U); % forward flight speed m/s
alpha = @(y) deg2rad(5)*ones(size(y)); % geometric angle of attack as a function of span location (radians)
dt = 1; % time step time (s)
nT = 200; % number of time steps

omega = [0 0 0]'*pi/30; % Rotaional speed, rad/s

targetIndices = 1:m:(m*(n+1)); % The start index of each filament


%% Fixed filements

% Define wing filament segment End points
wingSegmentPoints = linspace(-b/2,b/2,n+1);
FixedStartPoints = [zeros(1,n);wingSegmentPoints(1:end-1);zeros(1,n)];
FixedEndPoints = [zeros(1,n);wingSegmentPoints(2:end);zeros(1,n)];

% Points at which to calculate aoa, set as section midpoint for not
FixedSamplePoints = (FixedStartPoints + FixedEndPoints)/2;

% local X-Y vectors for wing sections
sectionX = repmat([cosd(5),0,-sind(5)]',[1,size(FixedSamplePoints,2)]);
sectionY = repmat([-sind(5),0,-cosd(5)]',[1,size(FixedSamplePoints,2)]);


% Initialize Wing Vorticity with Freestream
localBladeVelocity = cross(repmat(omega,[1,size(FixedSamplePoints,2)]),FixedSamplePoints,1);
sectionVelocity = repmat(U,[1,size(FixedSamplePoints,2)])-localBladeVelocity;
FixedAlpha = atan2(dot(sectionY,sectionVelocity,1),dot(-sectionX,sectionVelocity,1));
FixedCL = CLNACA0012(FixedAlpha);
FixedGamma = 1/2*Umag*FixedCL.*chord(FixedSamplePoints(2,:));
GammaList = -diff([0,FixedGamma,0]);

FixedRc = zeros(1,n);

%% Free Filaments
FreeStartPoints = [];
FreeEndPoints = [];
FreeFilamentIndex = []; % Index of which filament tube each filament belongs to
FreeGamma = [];
FreeRc = [];
% Define filament initial positions (straight lines propagated along the
% flow)
for ind1 = 1:n+1
    
    FreeStartPoints = [FreeStartPoints,kron((0:dt:(m-1)*dt),U)+repmat([0,wingSegmentPoints(ind1),0]',[1,m])];
    FreeEndPoints = [FreeEndPoints,kron((dt:dt:m*dt),U)+repmat([0,wingSegmentPoints(ind1),0]',[1,m])];
    
    FreeFilamentIndex = [FreeFilamentIndex,ind1*ones(1,m)];
    FreeGamma = [FreeGamma,GammaList(ind1)*ones(1,m)];
    FreeRc = [FreeRc,.1*ones(1,m)];
end

% Define Cross Vorticity
CrossStartPoints = FreeEndPoints(:,1:end-m);
CrossEndPoints = FreeEndPoints(:,(m+1):end);
CrossGamma = zeros(1,size(CrossStartPoints,2));
CrossRc = zeros(1,size(CrossStartPoints,2));


startPoints = [FixedStartPoints,FreeStartPoints,CrossStartPoints];
endPoints = [FixedEndPoints,FreeEndPoints,CrossEndPoints];
Gamma = [FixedGamma,FreeGamma,CrossGamma];
Rc = [FixedRc,FreeRc,CrossRc];


%%
FreeEndPointsStore = [];

% Iterate on positions
for ind2 = 1:nT
    
    % Select filaments to use to reduce computation
    selectedFilaments = find(abs(Gamma) > .01*max(abs(Gamma)));
    samplePoints = FreeStartPoints;
    
    % From present filaments, calculate new vorticities on the wing
    VInducedFixed = batchBiotSavart_mex(startPoints(:,selectedFilaments),endPoints(:,selectedFilaments),...
        Gamma(:,selectedFilaments),Rc(:,selectedFilaments),FixedSamplePoints);
    if any(isnan(VInducedFixed),'all')
       keyboard 
    end
    % FixedAlpha = alpha(FixedSamplePoints(2,:)) + atan2(VFixed(3,:),-(VFixed(1,:)-Umag));
    localBladeVelocity = cross(repmat(omega,[1,size(FixedSamplePoints,2)]),FixedSamplePoints,1);
    sectionVelocity = repmat(U,[1,size(VInducedFixed,2)]) - localBladeVelocity + VInducedFixed;
    FixedAlpha = atan2(dot(sectionY,sectionVelocity,1),dot(-sectionX,sectionVelocity,1));
    FixedCL = CLNACA0012(FixedAlpha);
    FixedGamma_Old = FixedGamma;
    FixedGamma = 1/2*Umag*FixedCL.*chord(FixedSamplePoints(2,:));
    GammaList = -diff([0,FixedGamma,0]);
    
    % Propagate the vorticities along the filament
    for ind5 = 1:n+1
        FreeGamma(targetIndices(ind5)+(1:m-1)) = FreeGamma(targetIndices(ind5)+(0:m-2));
    end
    
    % Propagate the new vorticities to the filament
    FreeGamma(targetIndices) = GammaList;
    
    % Propagate vorticity along the cross filaments
    for ind7 = 1:n
        CrossGamma(targetIndices(ind7)+(1:m-1)) = CrossGamma(targetIndices(ind7)+(0:m-2));
    end
    
    CrossGamma(targetIndices(1:end-1)) = FixedGamma_Old - FixedGamma;
    
    % Calculate Induced Velocities
    
    VInduced = batchBiotSavart_mex(...
        startPoints(:,selectedFilaments),endPoints(:,selectedFilaments),...
        Gamma(:,selectedFilaments),Rc(:,selectedFilaments),samplePoints);
    
    % Calculate timestepped vortex point locations (Forward Euler)
    FreeUpdate = FreeStartPoints + dt*(VInduced + repmat(U,[1,size(VInduced,2)]));
    
    % Reassign filament locations
    FreeEndPoints = FreeUpdate;
    FreeEndPointsStore(:,:,end+1) = FreeEndPoints;
    % Shift filament indices
    for ind3 = 1:n+1
        FreeStartPoints(:,targetIndices(ind3)+(1:m-1)) = FreeUpdate(:,targetIndices(ind3)+(0:m-2));
    end
    
    % Adjust Cross Vorticity Locations
    CrossStartPoints = FreeEndPoints(:,1:end-m);
    CrossEndPoints = FreeEndPoints(:,(m+1):end);
    
    % Update blade location
%     FixedStartPoints = rotZ(omega(3)*dt)*FixedStartPoints;
%     FixedEndPoints = rotZ(omega(3)*dt)*FixedEndPoints;
%     FixedSamplePoints = (FixedStartPoints + FixedEndPoints)/2;
    
    % Compile Results
    startPoints = [FixedStartPoints,FreeStartPoints,CrossStartPoints];
    endPoints = [FixedEndPoints,FreeEndPoints,CrossEndPoints];
    Gamma = [FixedGamma,FreeGamma,CrossGamma];
    Rc = [FixedRc,FreeRc,CrossRc];
    
   

end

plotResults