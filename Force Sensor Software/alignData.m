% Parses Data into 

clear
close all
clc

load('MeasuredForces.mat')

dataMatrix = zeros(size(forceMeasured));

for ind1 = 1:size(Data,2)
    
    RPM = Data{3,ind1};
    Select = find(RPM);
    
    Thrust = Data{1,ind1}(Select);
    Torque = Data{6,ind1}(Select);
    
    ThrustMatrix{ind1} =  Thrust;
    RPMMatrix{ind1} =  RPM(Select);
    TorqueMatrix{ind1} =  Torque;
    
    ForceMatrix{ind1} = forceMeasured(1:length(Select),ind1);
    
end
%%


save('AlignedData','RPMMatrix','ThrustMatrix','TorqueMatrix','ForceMatrix','positionX')
