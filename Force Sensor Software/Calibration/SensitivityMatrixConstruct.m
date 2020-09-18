% Construct the Sensitivity matrix for the Z Table V2


clear
close all
clc

load('CalibrationData.mat')
%%
nullEntries = [];

CalibrationMean(nullEntries,:) = [];

nSensor = 6;

TaredCalibration = zeros(size(CalibrationMean,1)-1,nSensor);

for ind1 = 2:size(CalibrationMean,1)
    
    TaredCalibration(ind1-1,:) = CalibrationMean(ind1,:) - CalibrationMean(1,:);
    
end

% Record applied loads

% Force in N
% Moment in Nm
g = 9.81;

m500 = .5;
m200 = .2;
m100 = .1;
m50 = .05;

r = .04;

% Model:
% C*Measurements = Loadings
% C = Loadings*Measurements^(-1)

ForceVectorList = kron(kron([1 1 1],[0 0 -1]'),g*[m50,m100,m200,m500]);
ForceLocationList = kron([[0 0 0]',[r 0 0]',[0 r 0]'],[1 1 1 1]);
MomentVectorList = cross(ForceLocationList,ForceVectorList);


extractComponent = @(in,direction) dot(in,kron(ones(1,size(in,2)),direction));

% % Force Z
Output1 = extractComponent(ForceVectorList,[0 0 1]');
% % Moment X
Output2 = extractComponent(MomentVectorList,[1 0 0]');
% % Moment Y
Output3 = extractComponent(MomentVectorList,[0 1 0]');

% Manual Calculation
% % Force Z
% Output1 = -g*kron([1 1 1],[m50,m100,m200,m500]);
% % Moment X
% Output2 = kron([0 0 r],-g*[m50,m100,m200,m500]);
% % Moment Y
% Output3 = kron([0 -r 0],-g*[m50,m100,m200,m500]);

Loadings = [Output1;
    Output2;
    Output3];

% Linear Model 
C = Loadings*pinv(TaredCalibration');

% Quadratic Model 
% C = Loadings*pinv([TaredCalibration,TaredCalibration.^2]');

% Test the Matrix 
% C*TaredCalibration(2,:)'

save('CalibrationMatrix','C')

