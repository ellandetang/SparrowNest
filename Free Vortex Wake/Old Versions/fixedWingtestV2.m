% define a fixed wing with linear airfoil along its span to test rollup etc
clear
close all
% clf
clc


% Convention of X forwards, Y right, Z down

% Useful definitions:
% kutta jukowski: L/span = rho V Gamma
% Cl(alpha) = 2*pi*alpha (radians)

rho = 1.225; % air density kg/m^3

% Create initial setup
b = 2; % wingspan (m)
chord = @(y) .1*ones(size(y)); % chord as a function of span location (m)
n = 20; % number of wing divisions,shedding and calculation happens at the divisions
m = 40; % number of filament divisions
U = 10; % forward flight speed m/s
alpha = @(y) deg2rad(5)*ones(size(y)); % geometric angle of attack as a function of span location (radians)
dt = .5; % time step time (s)
nT = 200; % number of time steps

wingControlPoints = linspace(-b/2,b/2,n+1);




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

CL = 2*pi*alpha(FixedSamplePoints(2,:));
FixedGamma = 1/2*U*CL.*chord(FixedSamplePoints(2,:));
GammaList = -diff([0,FixedGamma,0]);

FixedRc = zeros(1,n);

% Define filament initial positions
for ind1 = 1:n+1
    
    FreeStartPoints = [FreeStartPoints,[-U*(0:dt:(m-1)*dt); repmat(wingControlPoints(ind1),[1,m]);zeros(1,m)]];
    FreeEndPoints = [FreeEndPoints,[-U*(dt:dt:m*dt); repmat(wingControlPoints(ind1),[1,m]);zeros(1,m)]];
    
    FreeFilamentIndex = [FreeFilamentIndex,ind1*ones(1,m)];
    FreeGamma = [FreeGamma,GammaList(ind1)*ones(1,m)];
    FreeRc = [FreeRc,.1*ones(1,m)];
end

startPoints = [FixedStartPoints,FreeStartPoints];
endPoints = [FixedEndPoints,FreeEndPoints];
Gamma = [FixedGamma,FreeGamma];
Rc = [FixedRc,FreeRc];

%%
targetIndices = 1:m:size(FreeStartPoints,2);

FreeEndPointsStore = [];

% Iterate on positions
for ind2 = 1:nT

    % Calculate new vorticities
    VFixed = batchBiotSavart(startPoints,endPoints,Gamma,Rc,FixedSamplePoints);
    FixedAlpha = alpha(FixedSamplePoints(2,:)) + atan2(VFixed(3,:),-(VFixed(1,:)-U));
    FixedCL = 2*pi*FixedAlpha;
    FixedGamma = 1/2*U*FixedCL.*chord(FixedSamplePoints(2,:));
    GammaList = -diff([0,FixedGamma,0]);
    
    % Shift vorticities along the filament
    for ind5 = 1:n+1
        FreeGamma(targetIndices(ind5)+(1:m-1)) = FreeGamma(targetIndices(ind5)+(0:m-2));
    end
    
    FreeGamma(targetIndices) = GammaList;
    
    startPoints = [FixedStartPoints,FreeStartPoints];
    endPoints = [FixedEndPoints,FreeEndPoints];
    Gamma = [FixedGamma,FreeGamma];
    Rc = [FixedRc,FreeRc];
    
    samplePoints = FreeStartPoints;
    
    V = batchBiotSavart(startPoints,endPoints,Gamma,Rc,samplePoints);
    
    % Calculate timestepped vortex point locations
    FreeUpdate = FreeStartPoints + dt*(V + repmat([-U,0,0]',[1,size(V,2)]));
    FreeEndPoints = FreeUpdate;
    
    FreeEndPointsStore(:,:,end+1) = FreeEndPoints;
    
    % Shift filament indices
    for ind3 = 1:n+1
        FreeStartPoints(:,targetIndices(ind3)+(1:m-1)) = FreeUpdate(:,targetIndices(ind3)+(0:m-2));
    end
    
    
end

%% 
% Sample Velocity along the wing line


wingSample(2,:) = linspace(-b/2,b/2,101);
wingSample(3,1) = 0;
VSample = batchBiotSavart(startPoints,endPoints,Gamma,Rc,wingSample);


%% Plotting

indF = 0;

indF = indF + 1;
figure(indF)
for ind4 = 1:n+1
    
    filament = [FreeStartPoints(:,targetIndices(ind4)),FreeEndPoints(:,targetIndices(ind4)+(0:m-1))];
    line(filament(1,:),filament(2,:),filament(3,:),'marker','.','markersize',5)
    
end
view(45,45)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
% axis equal
ax = gca;
set(ax,'YDir','reverse','ZDir','reverse');

% Plot airfoil sections
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

%%
indF = indF + 1;
figure(indF)
line(FixedSamplePoints(2,:),FixedCL)
title('Section Lift Coefficient')
grid on

indF = indF + 1;
figure(indF)
line(wingSample(2,:),VSample(3,:))
title('Downwash Speed')
grid on

data(1,:) = wingSample(2,:);
data(2,:) = VSample(3,:);
save('data','data')

indF = indF + 1;
figure(indF)
line(wingSample(2,:),rad2deg(atan2(VSample(3,:),U)))
title('Downwash Angle')
ylabel('Downwash Angle (deg)')
grid on

% indF = indF + 1;
% figure(indF)
% positionError = diff(FreeEndPointsStore,1,3);
% positionError = sum(sqrt(sum(positionError.^2,1)),2);
% positionError = positionError(:);
% semilogy(1:nT,positionError)
% title('Change in collocation point positions')
% grid on
% 
% 
% indF = indF + 1;
% figure(indF)
% plot(1:m-1,diff(reshape(FreeGamma,[m,n+1]),1,1))
% title('Change in Circulation along each filament')
