b = 2; % wingspan (m)
chord = @(y) .1*ones(size(y)); % chord as a function of span location (m)

body(1).nWingSegments = 21; % number of wing segments,shedding and calculation happens at the divisions
body(1).nFilamentSegments = 20; % number of filament divisions

body(1).targetIndices = 1:body(1).nFilamentSegments:(body(1).nFilamentSegments*(body(1).nWingSegments+1)); % The start index of each filament


%% Fixed filements

% Define wing filament segment End points
wingSegmentPoints = linspace(-b/2,b/2,body(1).nWingSegments+1);
body(1).FixedStartPoints = [zeros(1,body(1).nWingSegments);wingSegmentPoints(1:end-1);zeros(1,body(1).nWingSegments)];
body(1).FixedEndPoints = [zeros(1,body(1).nWingSegments);wingSegmentPoints(2:end);zeros(1,body(1).nWingSegments)];

% Points at which to calculate aoa, set as section midpoint for not
body(1).FixedSamplePoints = (body(1).FixedStartPoints + body(1).FixedEndPoints)/2;

% local X-Y vectors for wing sections
body(1).sectionX = repmat([cosd(5),0,-sind(5)]',[1,size(body(1).FixedSamplePoints,2)]);
body(1).sectionY = repmat([-sind(5),0,-cosd(5)]',[1,size(body(1).FixedSamplePoints,2)]);
body(1).chord = chord(body(1).FixedSamplePoints(2,:));

% Initialize Wing Vorticity with Freestream
body(1).VInducedFixed = zeros(size(body(1).FixedSamplePoints));
body(1).FixedGamma = zeros(1,body(1).nWingSegments);

% localBladeVelocity = cross(repmat(omega,[1,size(body(1).FixedSamplePoints,2)]),body(1).FixedSamplePoints,1);
% sectionVelocity = repmat(U,[1,size(body(1).FixedSamplePoints,2)])-localBladeVelocity;
% FixedAlpha = atan2(dot(body(1).sectionY,sectionVelocity,1),dot(-body(1).sectionX,sectionVelocity,1));
% FixedCL = CLNACA0012(FixedAlpha);
% body(1).FixedGamma = 1/2*Umag*FixedCL.*chord(body(1).FixedSamplePoints(2,:));
body = calculateGamma(body,simulation);
GammaList = -diff([0,body(1).FixedGamma,0]);

FixedRc = zeros(1,body(1).nWingSegments);

%% Free Filaments
body(1).FreeStartPoints = [];
body(1).FreeEndPoints = [];
body(1).FreeFilamentIndex = []; % Index of which filament tube each filament belongs to
body(1).FreeGamma = [];
body(1).FreeRc = [];
body(1).FreeEndPointsStore = [];

% Define filament initial positions (straight lines propagated along the
% flow)
for ind1 = 1:body(1).nWingSegments+1
    
    body(1).FreeStartPoints = [body(1).FreeStartPoints,kron((0:simulation.dt:(body(1).nFilamentSegments-1)*simulation.dt),simulation.U)+repmat([0,wingSegmentPoints(ind1),0]',[1,body(1).nFilamentSegments])];
    body(1).FreeEndPoints = [body(1).FreeEndPoints,kron((simulation.dt:simulation.dt:body(1).nFilamentSegments*simulation.dt),simulation.U)+repmat([0,wingSegmentPoints(ind1),0]',[1,body(1).nFilamentSegments])];
    
    body(1).FreeFilamentIndex = [body(1).FreeFilamentIndex,ind1*ones(1,body(1).nFilamentSegments)];
    body(1).FreeGamma = [body(1).FreeGamma,GammaList(ind1)*ones(1,body(1).nFilamentSegments)];
    body(1).FreeRc = [body(1).FreeRc,.1*ones(1,body(1).nFilamentSegments)];
    
end

% Define Cross Vorticity
body(1).CrossStartPoints = body(1).FreeEndPoints(:,1:end-body(1).nFilamentSegments);
body(1).CrossEndPoints = body(1).FreeEndPoints(:,(body(1).nFilamentSegments+1):end);
body(1).CrossGamma = zeros(1,size(body(1).CrossStartPoints,2));
body(1).CrossRc = zeros(1,size(body(1).CrossStartPoints,2));


simulation.startPoints = [simulation.startPoints,body(1).FixedStartPoints,body(1).FreeStartPoints,body(1).CrossStartPoints];
simulation.endPoints = [simulation.endPoints,body(1).FixedEndPoints,body(1).FreeEndPoints,body(1).CrossEndPoints];
simulation.Gamma = [simulation.Gamma,body(1).FixedGamma,body(1).FreeGamma,body(1).CrossGamma];
simulation.Rc = [simulation.Rc,FixedRc,body(1).FreeRc,body(1).CrossRc];

