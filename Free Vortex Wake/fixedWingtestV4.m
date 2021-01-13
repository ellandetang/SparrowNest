% Define a fixed wing with linear airfoil along its span to test rollup etc

% Vectorize local blade angle of attack and freestream velocity

clear
close all
clc


% Convention of X forwards, Y right, Z down

% Useful definitions:
% kutta joukowski: L/span = rho V Gamma
% Cl(alpha) = 2*pi*alpha (radians)

rho = 1.225; % air density kg/m^3

% Create initial setup
b = 2; % wingspan (m)
chord = @(y) .1*ones(size(y)); % chord as a function of span location (m)
n = 21; % number of wing divisions,shedding and calculation happens at the divisions
m = 20; % number of filament divisions
U = [-10,0,0]'; % Free stream velocity vector, m/s
Umag = norm(U); % forward flight speed m/s
alpha = @(y) deg2rad(5)*ones(size(y)); % geometric angle of attack as a function of span location (radians)
dt = .5; % time step time (s)
nT = 200; % number of time steps

wingControlPoints = linspace(-b/2,b/2,n+1);

targetIndices = 1:m:(m*(n+1)); % The start index of each filament


% Free filaments, fixed filements

FreeStartPoints = [];
FreeEndPoints = [];
FreeFilamentIndex = []; % Index of which filament tube each filament belongs to
FreeGamma = [];
FreeRc = [];

% Define wing bound circulation
FixedStartPoints = [zeros(1,n);wingControlPoints(1:end-1);zeros(1,n)];
FixedEndPoints = [zeros(1,n);wingControlPoints(2:end);zeros(1,n)];

% Points at which to calculate aoa and the like
FixedSamplePoints = (FixedStartPoints + FixedEndPoints)/2;

% local X-Y vectors for wing sections
sectionX = repmat([cosd(5),0,-sind(5)]',[1,size(FixedSamplePoints,2)]);
sectionY = repmat([-sind(5),0,-cosd(5)]',[1,size(FixedSamplePoints,2)]);

% Initialize Wing Vorticity
sectionVelocity = repmat(U,[1,size(FixedSamplePoints,2)]);
FixedAlpha = -atan2(dot(sectionY,sectionVelocity,1),dot(sectionX,sectionVelocity,1));
FixedCL = 2*pi*FixedAlpha;
FixedGamma = 1/2*Umag*FixedCL.*chord(FixedSamplePoints(2,:));
GammaList = -diff([0,FixedGamma,0]);

FixedRc = zeros(1,n);

% Define filament initial positions (strait lines propagated in the flow
for ind1 = 1:n+1
    
    FreeStartPoints = [FreeStartPoints,kron((0:dt:(m-1)*dt),U)+repmat([0,wingControlPoints(ind1),0]',[1,m])];
    FreeEndPoints = [FreeEndPoints,kron((dt:dt:m*dt),U)+repmat([0,wingControlPoints(ind1),0]',[1,m])];
    
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
    VFixed = batchBiotSavart(startPoints(:,selectedFilaments),endPoints(:,selectedFilaments),...
        Gamma(:,selectedFilaments),Rc(:,selectedFilaments),FixedSamplePoints);
    % FixedAlpha = alpha(FixedSamplePoints(2,:)) + atan2(VFixed(3,:),-(VFixed(1,:)-Umag));
    sectionVelocity = -(VFixed+repmat(U,[1,size(VFixed,2)]));
    FixedAlpha = -atan2(dot(sectionY,sectionVelocity,1),dot(sectionX,sectionVelocity,1));
    FixedCL = 2*pi*FixedAlpha;
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
    
    V = batchBiotSavart(...
        startPoints(:,selectedFilaments),endPoints(:,selectedFilaments),...
        Gamma(:,selectedFilaments),Rc(:,selectedFilaments),samplePoints);
    
    % Calculate timestepped vortex point locations (Forward Euler)
    FreeUpdate = FreeStartPoints + dt*(V + repmat(U,[1,size(V,2)]));
    
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
    
    % Compile Results
    startPoints = [FixedStartPoints,FreeStartPoints,CrossStartPoints];
    endPoints = [FixedEndPoints,FreeEndPoints,CrossEndPoints];
    Gamma = [FixedGamma,FreeGamma,CrossGamma];
    Rc = [FixedRc,FreeRc,CrossRc];
end

%%
% Sample Velocity along the wing line


wingSample(2,:) = linspace(-b/2,b/2,101);
wingSample(3,1) = 0;
VSample = batchBiotSavart(startPoints,endPoints,Gamma,Rc,wingSample);


%% Plotting
close all

indF = 0;

indF = indF + 1;
figure(indF)
GammaMax = max(abs(Gamma));
GammaScaleF = @(in) interp1([0 GammaMax],[0,1],abs(in));
for ind4 = 1:n+1
    
    filamentStart = FreeStartPoints(:,targetIndices(ind4)+(0:m-1));
    filamentEnd = FreeEndPoints(:,targetIndices(ind4)+(0:m-1));
    filamentGamma = FreeGamma(targetIndices(ind4)+(0:m-1));
    for ind6 = 1:size(filamentStart,2)
        line([filamentStart(1,ind6),filamentEnd(1,ind6)]',...
            [filamentStart(2,ind6),filamentEnd(2,ind6)]',...
            [filamentStart(3,ind6),filamentEnd(3,ind6)]',...
            'marker','.','markersize',5,...
            'linewidth',.5,...
            'color',[1-GammaScaleF(filamentGamma(ind6)),0,GammaScaleF(filamentGamma(ind6))]);
    end
    
end

for ind8 = 1:size(CrossStartPoints,2)
    line([CrossStartPoints(1,ind8),CrossEndPoints(1,ind8)]',...
        [CrossStartPoints(2,ind8),CrossEndPoints(2,ind8)]',...
        [CrossStartPoints(3,ind8),CrossEndPoints(3,ind8)]',...
        'marker','.','markersize',5,...
        'linewidth',.5,...
        'color',[1-GammaScaleF(CrossGamma(ind8)),0,GammaScaleF(CrossGamma(ind8))]);
end


view(45,45)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
% axis equal
ax = gca;
set(ax,'YDir','reverse','ZDir','reverse');

% % Plot airfoil sections
% naca0012 = @(x,t) 5*t*(.2969*sqrt(x) - .126*x - .3516*x.^2 + .2843*x.^3 -.1015*x.^4);
% naca0012x = linspace(0,1,100);
% naca0012y = [naca0012(naca0012x,.12) -flip(naca0012(naca0012x,.12))];
% naca0012x = [naca0012x,flip(naca0012x)];
% for ind6 = 1:size(FixedSamplePoints,2)
%     scaling = chord(FixedSamplePoints(2,ind6));
%     xOffset = FixedSamplePoints(1,ind6) + scaling/4;
%     yOffset = FixedSamplePoints(2,ind6);
%     zOffset = FixedSamplePoints(3,ind6);
%     line(xOffset-scaling*naca0012x,yOffset+zeros(size(naca0012x)),zOffset - scaling*naca0012y)
% end



