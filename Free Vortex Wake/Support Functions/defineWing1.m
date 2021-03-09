% Define all the requisite variables for a wing in the simulation

b = 2; % wingspan (m)
chord = @(y) .1*ones(size(y)); % chord as a function of span location (m)

bodyIndex = 1;

body(bodyIndex).nWingSegments = 21; % number of wing segments,shedding and calculation happens at the divisions
body(bodyIndex).nFilamentSegments = 40; % number of filament divisions

body(bodyIndex).targetIndices = 1:body(bodyIndex).nFilamentSegments:(body(bodyIndex).nFilamentSegments*(body(bodyIndex).nWingSegments+1)); % The start index of each filament


%% Fixed filaments

% Define wing filament segment End points
wingSegmentPoints = [0*ones(1,body(bodyIndex).nWingSegments+1);linspace(-b/2,b/2,body(bodyIndex).nWingSegments+1);0*ones(1,body(bodyIndex).nWingSegments+1)];
body(bodyIndex).FixedStartPoints = wingSegmentPoints(:,1:end-1);
body(bodyIndex).FixedEndPoints = wingSegmentPoints(:,2:end);


% Points at which to calculate aoa, set as section midpoint for not
body(bodyIndex).FixedSamplePoints = (body(bodyIndex).FixedStartPoints + body(bodyIndex).FixedEndPoints)/2;

% local X-Y vectors for wing sections
body(bodyIndex).sectionX = repmat([cosd(5),0,-sind(5)]',[1,size(body(bodyIndex).FixedSamplePoints,2)]);
body(bodyIndex).sectionY = repmat([-sind(5),0,-cosd(5)]',[1,size(body(bodyIndex).FixedSamplePoints,2)]);
body(bodyIndex).chord = chord(body(bodyIndex).FixedSamplePoints(2,:));

% Initialize Wing Vorticity with Freestream
body(bodyIndex).VInducedFixed = zeros(size(body(bodyIndex).FixedSamplePoints));
body(bodyIndex).FixedGamma = zeros(1,body(bodyIndex).nWingSegments);

% localBladeVelocity = cross(repmat(omega,[1,size(body(bodyIndex).FixedSamplePoints,2)]),body(bodyIndex).FixedSamplePoints,1);
% sectionVelocity = repmat(U,[1,size(body(bodyIndex).FixedSamplePoints,2)])-localBladeVelocity;
% FixedAlpha = atan2(dot(body(bodyIndex).sectionY,sectionVelocity,1),dot(-body(bodyIndex).sectionX,sectionVelocity,1));
% FixedCL = CLNACA0012(FixedAlpha);
% body(bodyIndex).FixedGamma = 1/2*Umag*FixedCL.*chord(body(bodyIndex).FixedSamplePoints(2,:));
body = calculateGamma(body,simulation,1);
GammaList = -diff([0,body(bodyIndex).FixedGamma,0]);

body(bodyIndex).FixedRc = zeros(1,body(bodyIndex).nWingSegments);

%% Free Filaments
body(bodyIndex).FreeStartPoints = [];
body(bodyIndex).FreeEndPoints = [];
body(bodyIndex).FreeFilamentIndex = []; % Index of which filament tube each filament belongs to
body(bodyIndex).FreeGamma = [];
body(bodyIndex).FreeRc = [];
body(bodyIndex).FreeEndPointsStore = [];

% Define filament initial positions (straight lines propagated along the
% flow)
for ind1 = 1:body(bodyIndex).nWingSegments+1
    
    body(bodyIndex).FreeStartPoints = [body(bodyIndex).FreeStartPoints,...
        kron((0:simulation.dt:(body(bodyIndex).nFilamentSegments-1)*simulation.dt),simulation.U)+...
        repmat(wingSegmentPoints(:,ind1),[1,body(bodyIndex).nFilamentSegments])];
    body(bodyIndex).FreeEndPoints = [body(bodyIndex).FreeEndPoints,...
        kron((simulation.dt:simulation.dt:body(bodyIndex).nFilamentSegments*simulation.dt),simulation.U)+...
        repmat(wingSegmentPoints(:,ind1),[1,body(bodyIndex).nFilamentSegments])];
    
    body(bodyIndex).FreeFilamentIndex = [body(bodyIndex).FreeFilamentIndex,ind1*ones(1,body(bodyIndex).nFilamentSegments)];
    body(bodyIndex).FreeGamma = [body(bodyIndex).FreeGamma,GammaList(ind1)*ones(1,body(bodyIndex).nFilamentSegments)];
    body(bodyIndex).FreeRc = [body(bodyIndex).FreeRc,.1*ones(1,body(bodyIndex).nFilamentSegments)];
    
end

% Define Cross Vorticity
body(bodyIndex).CrossStartPoints = body(bodyIndex).FreeEndPoints(:,1:end-body(bodyIndex).nFilamentSegments);
body(bodyIndex).CrossEndPoints = body(bodyIndex).FreeEndPoints(:,(body(bodyIndex).nFilamentSegments+1):end);
body(bodyIndex).CrossGamma = zeros(1,size(body(bodyIndex).CrossStartPoints,2));
body(bodyIndex).CrossRc = zeros(1,size(body(bodyIndex).CrossStartPoints,2));


simulation.startPoints = [simulation.startPoints,body(bodyIndex).FixedStartPoints,body(bodyIndex).FreeStartPoints,body(bodyIndex).CrossStartPoints];
simulation.endPoints = [simulation.endPoints,body(bodyIndex).FixedEndPoints,body(bodyIndex).FreeEndPoints,body(bodyIndex).CrossEndPoints];
simulation.Gamma = [simulation.Gamma,body(bodyIndex).FixedGamma,body(bodyIndex).FreeGamma,body(bodyIndex).CrossGamma];
simulation.Rc = [simulation.Rc,body(bodyIndex).FixedRc,body(bodyIndex).FreeRc,body(bodyIndex).CrossRc];

