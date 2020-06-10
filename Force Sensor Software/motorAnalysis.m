% Generic RC Benchmark Data Analysis Script
clear
close all
clc

filenameList = ls('Baseline');
for ind1 = 1:size(filenameList,1)
    if any(regexp(filenameList(ind1,:),'StepsTest'))
        baselineDataIndex = ind1;
        break
    end
end
filename = ['Baseline\' filenameList(baselineDataIndex,:)];
T = readtable(filename);

%%

Thrust = T.Thrust_gf_/1000*9.81; %N
Torque = T.Torque_N_m_;
rpm = T.MotorElectricalSpeed_RPM_;
PMech = T.MechanicalPower_W_;
PElec = T.ElectricalPower_W_;

rho = 1.18; %kg/m^3
D = 10*.0254; %m
rpm2Om = 2*pi/60;

CT_Baseline = (rho*D^4*(rpm*rpm2Om).^2)\Thrust;
CQ_Baseline = (rho*D^5*(rpm*rpm2Om).^2)\Torque;

rpmMax = 150000/D*.0254;
rpmSample = linspace(0,rpmMax);

figure(1)

subplot(2,1,1)
line(rpm,Thrust,'marker','.','linestyle','none','color',[0 0 0])
line(rpmSample,rho*D^4*(rpmSample*rpm2Om).^2*CT_Baseline,'color',[0 0 0])
grid on
xlabel('RPM')
ylabel('Thrust (N)')

subplot(2,1,2)
line(rpm,Torque,'marker','.','linestyle','none','color',[0 0 0])
line(rpmSample,rho*D^5*(rpmSample*rpm2Om).^2*CQ_Baseline,'color',[0 0 0])
grid on
xlabel('RPM')
ylabel('Torque (N-m)')

figure(2)

line(rpm,PElec,'marker','.','linestyle','none','color',[0 0 0])
line(rpm,PMech,'marker','+','linestyle','none','color',[0 0 0])
grid on
xlabel('RPM')
ylabel('Power W')

figure(3)

line(rpm,PMech./PElec,'marker','.','linestyle','none','color',[0 0 0])
grid on
xlabel('RPM')
ylabel('Electic to Mechanical Efficiency')

save('baseline','CT_Baseline','CQ_Baseline','D','rho')