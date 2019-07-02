%% Autonomous Flying Ambulance Energy Consumption Calculator and range estimator
% by Ellande Tang
% last updated 2019-6-28

% 2019-1-25 Reorganized for more sensical workflow
% Changed battery adjustment power calculation
% 2019-1-28 Added Max Speed check for Acceleration
% added wrapper to calculate optimal acceleration aoa
% 2019-1-29 Added hover time section
% 2019-6-11 Incorporating more appropriate drag function for lifting rotor
% drag
% 2019-6-12 Include optimization in analysis
% 2019-6-28 Updated for different lifter and thruster props, 8 inch lifter
% props now

%% Transit Steps
% Ascent
% Acceleration
% Cruise
% Decceleration
% Descent

% clear
% close all

%% Make Parameters Global

% Verify all of these values are defined before moving to script

% % Environmental Parameters
% global g rho mass...
%     W N_lift N_thrust
% 
% % Vehicle aerodynamic characteristics
% global k_total CD0_total CLa_total...
%     CL0_total CLmax_total A_aero...
%     Cl Cd 
% 
% % Thruster drag increase model
% global LifterDrag Lift Drag
% 
% % Energy storage
% global batteryCells batteryVoltage batteryCapacity...
%     numBatteries UsableEnergyFactor capacity...
%     powerCorrection
% 
% % Propeller Parameters
% global D_lifter A_prop_lifter CT_lifter...
%     CQ_lifter RPSMax_lifter TMax_lifter...
%     rotorRPS_fun_lifter Ph_lifter RPS_h_lifter...
%     P0_per_lifter Cd0_rotor_lifter...
%     D_thruster A_prop_thruster CT_thruster...
%     CQ_thruster RPSMax_thruster TMax_thruster...
%     rotorRPS_fun_thruster Ph_thruster RPS_h_thruster...
%     P0_per_thruster Cd0_rotor_thruster...
%     kappa sigma_rotor...
%     thrusterPower lifterPower

%% Define Critical variables

% Environmental Parameters
% g = 9.81; % m/s^2

% rho = 1.0788; %kg/m^3
% rho = 1.1827; % Measured using CAST temperature and humidity


% Vehicle Properties
% mass = 7.67; %kg
mass = 8;
W = mass*g; %N
N_lift = 8;
N_thrust = 2;

% Vehicle aerodynamic characteristics

k_total     = 0.204214362612713;
CD0_total   = 0.070868390645897;
CLa_total   = 2.034367504585228; %[/rad]
CL0_total   = 0.360538456241375;
CLmax_total = 0.8500; % more than 9 deg

A_aero = .566;

Cl = @(alpha) CL0_total + CLa_total*alpha;

Cd = @(alpha) CD0_total + k_total*Cl(alpha)^2;

% Thruster drag increase model

LifterDrag = @(rpm,V,aoa)  (-4.378771958060490e-12/1.182*rho*(rad2deg(max(aoa,0)) - 90)).*V.*rpm.^2;

Lift = @(V,alpha) 1/2*rho*V.^2*Cl(alpha)*A_aero;
Drag = @(V,alpha,rpm) 1/2*rho*V.^2*Cd(alpha)*A_aero +...
    LifterDrag(rpm,V,alpha)*N_lift;


% Energy storage
% 2 5S 6000 mAh Batteries weight 710g each or
% 2 6S 6000 mAh Batteries weight 
% batteryVoltage = 18.5; % V
batteryCells = 6;
batteryVoltage = 3.7*batteryCells;
batteryCapacity = 6; % Ah
numBatteries = 2;
UsableEnergyFactor = .8;
capacity = numBatteries * batteryVoltage * batteryCapacity * UsableEnergyFactor * 3600; %J
% Power Correction Function based on battery capacity
powerCorrection = @(P) adjusted_Electric_Energy_Consumption(P, capacity, .8, 1, 1.3);
% powerCorrection = @(P) P;


% Lifter Propeller Parameters
D_lifter = 8*.0254; % meters;
A_prop_lifter = (D_lifter/2)^2*pi;
CT_lifter = .1448; %(Thrust in N = CT*rho*rps^2*D^4)
CQ_lifter = .0106; % (Torque in N*m = CQ*rho*rps^2*D^5)
RPSMax_lifter = 341;
TMax_lifter = CT_lifter*rho*RPSMax_lifter^2*D_lifter^4;

% Thruster Propeller Parameters
D_thruster = 7*.0254; % meters;
A_prop_thruster = (D_thruster/2)^2*pi;
CT_thruster = .1448; %(Thrust in N = CT*rho*rps^2*D^4)
CQ_thruster = .0106; % (Torque in N*m = CQ*rho*rps^2*D^5)
RPSMax_thruster = 341;
TMax_thruster = CT_thruster*rho*RPSMax_thruster^2*D_thruster^4;

% Propeller Model Parameters

kappa   = 1.15; % induced power correction factor
sigma_rotor  = 0.15;

%% Propeller Properties calculation

 
% For Lifters

% Calculates required RPS from thrust in static conditions
rotorRPS_fun_lifter = @(T) sqrt(T./(CT_lifter*rho*D_lifter^4));

% Use hover properties to derive profile coefficients
[Ph_lifter, ~] = calculate_rotor_vertical_flight_power(W/N_lift,0,rho,A_prop_lifter);
RPS_h_lifter = rotorRPS_fun_lifter(W/N_lift);
% Subtract ideal power from disk actuator theory from measured power to get
% profile power coefficients
P0_per_lifter = (2*pi*CQ_lifter)*(rho*RPS_h_lifter^3*D_lifter^5) - Ph_lifter;
Cd0_rotor_lifter = 32*P0_per_lifter/(sigma_rotor*pi^4*rho*RPS_h_lifter^3*D_lifter^5);
% P0 = N_lift * calculate_rotor_profile_power(0,rho, 2*pi*RPS_h ,D/2, sigma_rotor, Cd0_rotor);

% Calculates Power per Lifter Rotor
lifterPower = @(T,V,alpha) calculate_rotor_forward_flight_power(T, V, alpha, rho, A_prop_lifter) + ...
    calculate_rotor_profile_power(V,rho, 2*pi*rotorRPS_fun_lifter(T),D_lifter/2, sigma_rotor, Cd0_rotor_lifter);



% For Thruster

% Calculates required RPS from thrust in static conditions
rotorRPS_fun_thruster = @(T) sqrt(T./(CT_thruster*rho*D_thruster^4));

% Use hover properties to derive profile coefficients
[Ph_thruster, ~] = calculate_rotor_vertical_flight_power(W/N_lift,0,rho,A_prop_thruster);
RPS_h_thruster = rotorRPS_fun_thruster(W/N_lift);
% Subtract ideal power from disk actuator theory from measured power to get
% profile power coefficients
P0_per_thruster = (2*pi*CQ_thruster)*(rho*RPS_h_thruster^3*D_thruster^5) - Ph_thruster;
Cd0_rotor_thruster = 32*P0_per_thruster/(sigma_rotor*pi^4*rho*RPS_h_thruster^3*D_thruster^5);
% P0 = N_lift * calculate_rotor_profile_power(0,rho, 2*pi*RPS_h ,D/2, sigma_rotor, Cd0_rotor);


% Calculates Power per Thruster Rotor
thrusterPower = @(T,V,alpha) calculate_rotor_vertical_flight_power(T, V , rho, A_prop_thruster) + ...
    calculate_rotor_profile_power(V,rho, 2*pi*rotorRPS_fun_thruster(T),D_thruster/2, sigma_rotor, Cd0_rotor_thruster);



%% Ascent

% Choose target altitude and ascent speed
altCruise = 100; % m

MaxAcc = (TMax_lifter*N_lift - W)/mass;
AscentSpeedList = linspace(2,15,5);
AscentAccList = linspace(1,MaxAcc,5);

for ind1 = 1:length(AscentSpeedList)
    for ind2 = 1:length(AscentAccList)
        AscentSpeed = AscentSpeedList(ind1);
        AscentAcc = AscentAccList(ind2);
        
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
        
        AscentEnergySearch(ind1,ind2) = AscentAccEnergy + AscentCruiseEnergy;
        
    end
end

% figure(1)

% [X,Y] = meshgrid(AscentSpeedList,AscentAccList);
% surf(X,Y,AscentEnergySearch','FaceAlpha',0.5);
% title('Energy consumption of different acceleration profiles','interpreter','latex')
% xlabel('Ascent Steady Speed $\frac{m}{s}$','interpreter','Latex')
% ylabel('Ascent Acceleration $\frac{m}{s^2}$','interpreter','Latex')
% zlabel('Consumed Energy','interpreter','Latex')

% Finds grid search minimum
[AscentEnergyTemp,AscentEnergyIndexTemp] = min(AscentEnergySearch);
[AscentEnergy,AscentEnergyInd2] = min(AscentEnergyTemp);
AscentEnergyInd1 = AscentEnergyIndexTemp(AscentEnergyInd2);
AscentSpeed = AscentSpeedList(AscentEnergyInd1);
AscentAcc = AscentAccList(AscentEnergyInd2);

AscentTime = AscentSpeed/AscentAcc + (altCruise - 1/2*AscentAcc*(AscentSpeed/AscentAcc)^2)/AscentSpeed;

in0 = [AscentSpeed,AscentAcc]';

costF = @(in) ascentCostFunction(in(1),in(2));

options = optimoptions('fmincon','Display','none');
[AscentOpt,AscentEnergyOpt] = ...
    fmincon(costF,...
    in0,...
    [],[],...
    [],[],...
    [2 1]',[15,MaxAcc]',...
    [],options);

AscentSpeedOpt = AscentOpt(1);
AscentAccOpt = AscentOpt(2);

% line(AscentSpeedOpt,AscentAccOpt,AscentEnergyOpt,'marker','o','color',[1,0,0],'MarkerFaceColor',[1 0 0]);

%% Steady State Cruise Speed
% Calculate optimum cruise speed based on vehicle's power consumption

clear('CruiseAoAList','CruiseSpeedList','CruiseEffectiveDragSearch','MaxCruiseSpeed')

CruiseAoAList = deg2rad(linspace(-4,10,5));

for ind1 = 1:length(CruiseAoAList)
    CruiseAoA = CruiseAoAList(ind1);
    
    MaxCruiseSpeed(ind1) = fzero(@(V) Lift(V,CruiseAoA) - W,30);
    
    %     if MaxCruiseSpeed(ind1) > 27
    %        continue
    %     end
    
    % Check Speeds up to cruise speed for a given AoA
    CruiseSpeedList(ind1,:) = linspace(1,MaxCruiseSpeed(ind1),5);
    
    for ind2 = 1:size(CruiseSpeedList,2)
        
        CruiseSpeed = CruiseSpeedList(ind1,ind2);
        
        CruiseLiftDeficit = W - Lift(CruiseSpeed,CruiseAoA);
        
        % Sanitizes Calculation Results
        if abs(CruiseLiftDeficit)<1e-10
            CruiseLiftDeficit = 0;
        end
        
        CruiseRPM = rotorRPS_fun_lifter(CruiseLiftDeficit/N_lift)*60;
        
        if ind2 == length(CruiseSpeedList)
            CruisePower(ind1,ind2) = powerCorrection(N_thrust*...
                thrusterPower(Drag(CruiseSpeed,CruiseAoA,CruiseRPM)/N_thrust,CruiseSpeed,CruiseAoA));
        else
            % angle is negative because positive angle brings propeller
            % more aligned with freestream
            CruisePower(ind1,ind2) = powerCorrection(N_lift*lifterPower(CruiseLiftDeficit/N_lift,CruiseSpeed,-CruiseAoA)...
                + N_thrust*thrusterPower(Drag(CruiseSpeed,CruiseAoA,CruiseRPM)/N_thrust,CruiseSpeed,CruiseAoA));
        end
        
        CruiseEffectiveDragSearch(ind1,ind2) = CruisePower(ind1,ind2)/CruiseSpeed;
    end
    
end

% figure(2)
% 
% % Plot results
% surf(rad2deg(repmat(CruiseAoAList',[1,size(CruiseSpeedList,2)])),CruiseSpeedList,CruiseEffectiveDragSearch,'FaceAlpha',0.5)
% title('Power consumption of different cruise configurations','interpreter','Latex')
% xlabel('Angle of Attack (deg)','interpreter','Latex')
% ylabel('Cruise Speed $\frac{m}{s}$','interpreter','Latex')
% zlabel('Power/Speed','interpreter','Latex')

%%
% Finds grid search minimum
[CruiseEffectiveDragTemp,CruiseEffectiveDragIndexTemp] = min(CruiseEffectiveDragSearch);
[CruiseEffectiveDrag,CruiseEffectiveDragInd2] = min(CruiseEffectiveDragTemp);
CruiseEffectiveDragInd1 = CruiseEffectiveDragIndexTemp(CruiseEffectiveDragInd2);
CruiseAoA = CruiseAoAList(CruiseEffectiveDragInd1);
CruiseSpeed = CruiseSpeedList(CruiseEffectiveDragInd1,CruiseEffectiveDragInd2);

% line(rad2deg(CruiseAoA),CruiseSpeed,CruiseEffectiveDrag,'marker','o','color',[1,0,0],'MarkerFaceColor',[1 0 0]);
%%

scalingFactor1 = 1;
scalingFactor2 = 1;

in0 = [CruiseAoA/scalingFactor1,CruiseSpeed/scalingFactor2]';

costF = @(in) cruiseCostFunction(in(1)*scalingFactor1,in(2)*scalingFactor2);
conF = @(in) cruiseNonLCon(in(1)*scalingFactor1,in(2)*scalingFactor2);

options = optimoptions('fmincon','Display','none','StepTolerance',1e-10);
[CruiseOpt,CruiseEffectiveDragOpt1] = ...
    fmincon(costF,...
    in0,...
    [],[],...
    [],[],...
    [deg2rad(-4)/scalingFactor1 10/scalingFactor2]',[deg2rad(10)/scalingFactor1 35/scalingFactor2]',...
    conF,options);

CruiseAoAOpt1 = CruiseOpt(1)*scalingFactor1;
CruiseSpeedOpt1 = CruiseOpt(2)*scalingFactor2;

% CruiseSpeedOpt = fzero(@(V) Lift(V,CruiseAoAOpt) - W,30);

% line(rad2deg(CruiseAoAOpt1),CruiseSpeedOpt1,CruiseEffectiveDragOpt1,'marker','o','color',[1,0,0],'MarkerFaceColor',[rand rand rand]);


scalingFactor1 = 1;

in0 = CruiseAoA/scalingFactor1;

costF = @(in) cruiseCostFunctionAoa(in*scalingFactor1);

options = optimoptions('fmincon','Display','none','StepTolerance',1e-10);
[CruiseAoAOpt2,CruiseEffectiveDragOpt2] = ...
    fmincon(costF,...
    in0,...
    [],[],...
    [],[],...
    [deg2rad(-4)/scalingFactor1]',[deg2rad(10)/scalingFactor1]',...
    [],options);

CruiseSpeedOpt2 = fzero(@(V) Lift(V,CruiseAoAOpt2) - W,30);

% line(rad2deg(CruiseAoAOpt2),CruiseSpeedOpt2,CruiseEffectiveDragOpt2,'marker','o','color',[1,0,0],'MarkerFaceColor',[rand rand rand]);

[CruiseEffectiveDragOpt,selInd] = min([CruiseEffectiveDragOpt1,CruiseEffectiveDragOpt2]);
if selInd == 1
    CruiseAoAOpt = CruiseAoAOpt1;
    CruiseSpeedOpt = CruiseSpeedOpt1;
else
    CruiseAoAOpt = CruiseAoAOpt2;
    CruiseSpeedOpt = CruiseSpeedOpt2;
end

%% Acceleration

% For each cruise speed, choose an angle of attack to accelerate at. Simulate
% this acceleration and calculate the total energy consumption of this
% process

TargetCruiseSpeed = CruiseSpeedOpt;

AccAoAList = deg2rad(linspace(-4,10,29));

% Calculate Max Speeds at each angle of attack to check if acceleration is
% possible

options = optimoptions('fsolve','Display','none');
T = @(V) fsolve(@(T) T/2*(V + sqrt(V.^2 + 2*T/(rho*A_prop_thruster))) - TMax_thruster^(3/2)/sqrt(2*rho*A_prop_thruster),TMax_thruster,options);

Vmax = zeros(size(AccAoAList));
AccEnergy = zeros(size(AccAoAList));

for ind1 = 1:length(AccAoAList)
    Vmax(ind1) = fsolve(@(V) 2*T(V)*cos(AccAoAList(ind1)) - Drag(V,AccAoAList(ind1),0),30,options);
end

% figure(3)
% plot(rad2deg(AccAoAList),Vmax,'k')
% xlabel('Angle of Attack (deg)','interpreter','latex')
% ylabel('Max Speed $\frac{m}{s}$','interpreter','latex')

% Aim for level flight
% Accelerate to desired cruise speed
for ind1 = 1:length(AccAoAList)
    
    if Vmax(ind1) > TargetCruiseSpeed
        % Simulate acceleration using an ode solver
        
        % System Dynamics
        f = @(t,x) [x(2);
            (N_thrust*T(x(2)) - Drag(x(2),AccAoAList(ind1),rotorRPS_fun_thruster(max([0,(W - Lift(x(2),AccAoAList(ind1)))])/N_lift)*60))/mass];
         
        optionsAcc = odeset('RelTol',1e-8,'Events',@(t,x)  accEventFun(t,x(2) - TargetCruiseSpeed));
        % Simulate over long timespan
        [t,x,te,xe]  = ode45(f,[0,100],[0,0]',optionsAcc);
   
%         figure(4)
%         plot(t,x(:,2),'marker','.')
%         line(t,TargetCruiseSpeed*ones(size(t)))
%         xlim([0,12])
%         keyboard

        % Create continuous function for integration for speed and thrust
        AccSpeedProfile = @(tSample) interp1(t,x(:,2),tSample);
        
        AccLifterThrust = @(tSample) interp1(t,(W - Lift(x(:,2),AccAoAList(ind1)))/N_lift,tSample);
        
        % Craft Power function for a trajectory
        AccLifterTotalPower = @(tSample) N_lift*lifterPower(...
            max([zeros(size(AccLifterThrust(tSample))),AccLifterThrust(tSample)]),...
            interp1(t,x(:,2),tSample),-AccAoAList(ind1));
        
        % Integrate to find total energy consumption
        AccEnergy(ind1) = integral(@(tSample)...
            powerCorrection(N_thrust*thrusterPower(TMax_thruster,AccSpeedProfile(tSample),AccAoAList(ind1)) + AccLifterTotalPower(tSample)),0,te);
        
    else
        % If desired cruise speed is not reachable, make energy
        % requirement excessively large
        AccEnergy(ind1) = 1e10;
    end
end

[AccEnergyMin,I] = min(AccEnergy);

% figure(4)
% 
% plot(rad2deg(AccAoAList(AccEnergy<1e7)),AccEnergy(AccEnergy<1e7),'k','marker','.')
% xlabel('Angle of Attack (deg)')
% ylabel('Energy Required for Acceleration (J)')

%% Decceleration
% potentially small, may ignore for now

% Calculate energy required to hover while deccelerating
DeccEnergy = 0;

%% Descent

% Calculate energy required to hover while descending at constant speed

DescentDistance = 100; %m
DescentSpeed = 5; % m/s

DescentPower = N_lift*lifterPower(W/N_lift,0,pi/2);

DescentEnergy = powerCorrection(DescentPower)*DescentDistance/DescentSpeed;

%% Hover

% Calculate energy required to hover for a certain amount of time

HoverTime = 0; %s

HoverPower = N_lift*lifterPower(W/N_lift,0,pi/2);

HoverEnergy = powerCorrection(HoverPower)*HoverTime;

%% Calculate cruise range from remaining capacity

CalculatedRange = (capacity - (AscentEnergyOpt+AccEnergyMin+DeccEnergy+DescentEnergy+HoverEnergy))/CruiseEffectiveDragOpt; %m

CruiseEnergy = CruiseEffectiveDragOpt*CalculatedRange;

%% Display Results

% disp(['Ascent:' num2str(AscentEnergyOpt/capacity*100) '%'])
% 
% disp(['Acceleration:' num2str(AccEnergyMin/capacity*100) '%'])
% 
% disp(['Cruise:' num2str(CruiseEnergy/capacity*100) '%'])
% 
% disp(['Deceleration:' num2str(DeccEnergy/capacity*100) '%'])
% 
% disp(['Descent:' num2str(DescentEnergy/capacity*100) '%'])
% 
% disp(['Hover:' num2str(HoverEnergy/capacity*100) '%'])
% 
% disp(['Range:', num2str(CalculatedRange/1000), 'km'])
 

%% Function

function [position,isterminal,direction] = accEventFun(t,x)
position = x; % The value that we want to be zero
isterminal = 1;  % Halt integration 
direction = 0; % Either direction
end