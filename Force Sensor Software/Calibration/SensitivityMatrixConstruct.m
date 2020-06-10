
clear
close all
clc

load('CalibrationDataZTable.mat')
%%
nullEntries = [];

CalibrationMean(nullEntries,:) = [];

nSensor = 3;

TaredCalibration = zeros(size(CalibrationMean,1)-1,nSensor);

for ind1 = 2:size(CalibrationMean,1)
    
    TaredCalibration(ind1-1,:) = CalibrationMean(ind1,:) - CalibrationMean(1,:);
    
end

% Force in N
% Moment in Nm
g = 9.81;

m500 = .5;
m200 = .2;
m100 = .1;
m50 = .05;

r500 = .03748/2; % m Calibration Weight
r200 = .02882/2;
r100 = .02187/2;
r50 = .01801/2;
r2 = .00982/2; % m Screw Head

x = (.045+.03)/2;
y500 = .06-sqrt((r500+r2)^2 - (.015/2)^2);
y200 = .06-sqrt((r200+r2)^2 - (.015/2)^2);
y100 = .06-sqrt((r100+r2)^2 - (.015/2)^2);
y50 = .06-sqrt((r50+r2)^2 - (.015/2)^2);

% Model:
% C*Measurements = Loadings
% C = Loadings*Measurements^(-1)


Forces = g*-[.5 .5 .5 .5 .2 .2 .2 .2 .1 .1 .1 .1 .05 .05 .05 .05];
MomentsX = -g*kron([m500*y500, m200*y200 , m100*y100 , m50*y50],[1 1 -1 -1]);
MomentsY = g*kron([m500,m200,m100,m50],x*[1 -1 -1 1]);

Loadings = [Forces;
    MomentsX;
    MomentsY];

% Linear Model 
C = Loadings*pinv(TaredCalibration');

% Quadratic Model 
% C = Loadings*pinv([TaredCalibration,TaredCalibration.^2]');

% Test the Matrix 
% C*TaredCalibration(2,:)'

save('CalibrationMatrixZTable','C')

