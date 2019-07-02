function [AscentEnergy] = ascentCostFunction(AscentSpeed,AscentAcc)

% globalVariableDefinition
%%
% Environmental Parameters
global g rho mass...
    W N_lift N_thrust

% Vehicle aerodynamic characteristics
global k_total CD0_total CLa_total...
    CL0_total CLmax_total A_aero...
    Cl Cd 

% Thruster drag increase model
global LifterDrag Lift Drag

% Energy storage
global batteryCells batteryVoltage batteryCapacity...
    numBatteries UsableEnergyFactor capacity...
    powerCorrection

% Propeller Parameters
global D A_prop CT...
    CQ RPSMax TMax...
    kappa sigma_rotor...
    rotorRPS_fun Ph RPS_h...
    P0_per Cd0_rotor thrusterPower...
    lifterPower
%%

altCruise = 100; % m

% Calculates operation times
AscentAccTime = min([sqrt(2*altCruise/AscentAcc) AscentSpeed/AscentAcc]);
AscentCruiseTime = max([(altCruise - 1/2*AscentAcc*AscentAccTime^2)/AscentSpeed,0]);
AscentAccThrust = 1/2*rho*AscentSpeed^2*A_aero + mass*AscentAcc + W;
AscentCruiseThrust = 1/2*rho*AscentSpeed^2*A_aero + W;

% Calculate acceleration energy

AscentAccEnergy = integral(@(t) powerCorrection(N_lift*lifterPower(AscentAccThrust/N_lift,AscentAcc*t,pi/2)),0,AscentAccTime);

% Angle is pi/2 because thrust is aligned with flow direction

% Calculate hover energy until desired height achieved
AscentCruiseEnergy = integral(@(t) ...
    powerCorrection(N_lift*ones(size(t))*lifterPower(AscentCruiseThrust/N_lift,AscentSpeed,pi/2)),0,AscentCruiseTime);

AscentEnergy = AscentAccEnergy + AscentCruiseEnergy;

end

