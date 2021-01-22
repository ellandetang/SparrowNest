b = 1; % wingspan (m)
chord = @(y) .1*ones(size(y)); % chord as a function of span location (m)

body(2).nWingSegments = 21; % number of wing segments,shedding and calculation happens at the divisions
body(2).nFilamentSegments = 40; % number of filament divisions

body(2).targetIndices = 1:body(2).nFilamentSegments:(body(2).nFilamentSegments*(body(2).nWingSegments+1)); % The start index of each filament


%% Fixed filements

% Define wing filament segment End points
wingSegmentPoints = [-1*ones(1,body(2).nWingSegments+1);linspace(-b/2,b/2,body(2).nWingSegments+1);-.05*ones(1,body(2).nWingSegments+1)];
body(2).FixedStartPoints = wingSegmentPoints(:,1:end-1);
body(2).FixedEndPoints = wingSegmentPoints(:,2:end);

% Points at which to calculate aoa, set as section midpoint for not
body(2).FixedSamplePoints = (body(2).FixedStartPoints + body(2).FixedEndPoints)/2;

% local X-Y vectors for wing sections
body(2).sectionX = repmat([cosd(5),0,-sind(5)]',[1,size(body(2).FixedSamplePoints,2)]);
body(2).sectionY = repmat([-sind(5),0,-cosd(5)]',[1,size(body(2).FixedSamplePoints,2)]);
body(2).chord = chord(body(2).FixedSamplePoints(2,:));

% Initialize Wing Vorticity with Freestream
body(2).VInducedFixed = zeros(size(body(2).FixedSamplePoints));
body(2).FixedGamma = zeros(1,body(2).nWingSegments);

% localBladeVelocity = cross(repmat(omega,[1,size(body(2).FixedSamplePoints,2)]),body(2).FixedSamplePoints,1);
% sectionVelocity = repmat(U,[1,size(body(2).FixedSamplePoints,2)])-localBladeVelocity;
% FixedAlpha = atan2(dot(body(2).sectionY,sectionVelocity,1),dot(-body(2).sectionX,sectionVelocity,1));
% FixedCL = CLNACA0012(FixedAlpha);
% body(2).FixedGamma = 1/2*Umag*FixedCL.*chord(body(2).FixedSamplePoints(2,:));
body = calculateGamma(body,simulation,2);
GammaList = -diff([0,body(2).FixedGamma,0]);

FixedRc = zeros(1,body(2).nWingSegments);

%% Free Filaments
body(2).FreeStartPoints = [];
body(2).FreeEndPoints = [];
body(2).FreeFilamentIndex = []; % Index of which filament tube each filament belongs to
body(2).FreeGamma = [];
body(2).FreeRc = [];
body(2).FreeEndPointsStore = [];

% Define filament initial positions (straight lines propagated along the
% flow)
for ind1 = 1:body(2).nWingSegments+1
    
    body(2).FreeStartPoints = [body(2).FreeStartPoints,...
        kron((0:simulation.dt:(body(2).nFilamentSegments-1)*simulation.dt),simulation.U)+...
        repmat(wingSegmentPoints(:,ind1),[1,body(2).nFilamentSegments])];
    body(2).FreeEndPoints = [body(2).FreeEndPoints,...
        kron((simulation.dt:simulation.dt:body(2).nFilamentSegments*simulation.dt),simulation.U)+...
        repmat(wingSegmentPoints(:,ind1),[1,body(2).nFilamentSegments])];
    
    body(2).FreeFilamentIndex = [body(2).FreeFilamentIndex,ind1*ones(1,body(2).nFilamentSegments)];
    body(2).FreeGamma = [body(2).FreeGamma,GammaList(ind1)*ones(1,body(2).nFilamentSegments)];
    body(2).FreeRc = [body(2).FreeRc,.1*ones(1,body(2).nFilamentSegments)];
    
end

% Define Cross Vorticity
body(2).CrossStartPoints = body(2).FreeEndPoints(:,1:end-body(2).nFilamentSegments);
body(2).CrossEndPoints = body(2).FreeEndPoints(:,(body(2).nFilamentSegments+1):end);
body(2).CrossGamma = zeros(1,size(body(2).CrossStartPoints,2));
body(2).CrossRc = zeros(1,size(body(2).CrossStartPoints,2));


simulation.startPoints = [simulation.startPoints,body(2).FixedStartPoints,body(2).FreeStartPoints,body(2).CrossStartPoints];
simulation.endPoints = [simulation.endPoints,body(2).FixedEndPoints,body(2).FreeEndPoints,body(2).CrossEndPoints];
simulation.Gamma = [simulation.Gamma,body(2).FixedGamma,body(2).FreeGamma,body(2).CrossGamma];
simulation.Rc = [simulation.Rc,FixedRc,body(2).FreeRc,body(2).CrossRc];

