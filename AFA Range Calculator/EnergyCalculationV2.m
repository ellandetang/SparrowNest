%% Autonomous Flying Ambulance Energy Consumption Calculator and range estimator
% by Ellande Tang
% last updated 2019-6-1

% 2019-1-25 Reorganized for more sensical workflow
% Changed battery adjustment power calculation
% 2019-1-28 Added Max Speed check for Acceleration
% added wrapper to calculate optimal acceleration aoa
% 2019-1-29 Added hover time section
% 2019-6-11 Incorporating more appropriate drag function for lifting rotor
% drag

%% Transit Steps
% Ascent
% Acceleration
% Cruise
% Decceleration
% Descent

clear
close all
%% Define Critical variables

% Environmental Parameters
g = 9.81; % m/s^2
rho = 1.225; %kg/m^3

% Vehicle Properties
% mass = 7.67; %kg
mass = 8.5;
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

LifterDrag = @(rpm,V,aoa)  (-4.378771958060490e-12*(aoa - 90)).*V.*rpm.^2;

Lift = @(V,alpha) 1/2*rho*V.^2*Cl(alpha)*A_aero;
Drag = @(V,alpha,throttle) 1/2*rho*V.^2*Cd(alpha,throttle)*A_aero;


% Energy storage
% 2 5S 6000 mAh Batteries weight 710g each
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

% Propeller Parameters
D = 7*.0254; % meters;
A_prop = (D/2)^2*pi;
CT = .1448; %(Thrust in N = CT*rho*rps^2*D^4)
CQ = .0106; % (Torque in N*m = CQ*rho*rps^2*D^5)
RPSMax = 341;
TMax = CT*rho*RPSMax^2*D^4;

% Propeller Model Parameters

kappa   = 1.15; % induced power correction factor
sigma_rotor  = 0.15;

%% Propeller Properties calculation

% Calculates required RPS from thrust in static conditions
rotorRPS_fun = @(T) sqrt(T./(CT*rho*D^4));
rotorThrottle_fun = @(T) T/TMax;

% Use hover properties to derive profile coefficients
[Ph, ~] = calculate_rotor_vertical_flight_power(W/N_lift,0,rho,A_prop);
RPS_h = rotorRPS_fun(W/N_lift);
% Subtract ideal power from disk actuator theory from measured power to get
% profile power coefficients
P0_per = (2*pi*CQ)*(rho*RPS_h^3*D^5) - Ph;
Cd0_rotor = 32*P0_per/(sigma_rotor*pi^4*rho*RPS_h^3*D^5);
% P0 = N_lift * calculate_rotor_profile_power(0,rho, 2*pi*RPS_h ,D/2, sigma_rotor, Cd0_rotor);

% Calculates Power per Thruster Rotor
thrusterPower = @(T,V,alpha) calculate_rotor_vertical_flight_power(T, V , rho, A_prop) + ...
    calculate_rotor_profile_power(V,rho, 2*pi*rotorRPS_fun(T),D/2, sigma_rotor, Cd0_rotor);

% Calculates Power per Lifter Rotor
lifterPower = @(T,V,alpha) calculate_rotor_forward_flight_power(T, V, alpha, rho, A_prop) + ...
    calculate_rotor_profile_power(V,rho, 2*pi*rotorRPS_fun(T),D/2, sigma_rotor, Cd0_rotor);


%% Ascent

% Choose target altitude and ascent speed
altCruise = 100; % m

MaxAcc = (2.2*N_lift*9.81 - W)/mass;
AscentSpeedList = linspace(2,15,50);
AscentAccList = linspace(1,13,30);

for ind1 =1:length(AscentSpeedList)
    for ind2 = 1:length(AscentAccList)
        AscentSpeed = AscentSpeedList(ind1);
        AscentAcc = AscentAccList(ind2);
        
        % Calculates operation times
        AscentAccTime = min([sqrt(2*altCruise/AscentAcc) AscentSpeed/AscentAcc]);
        AscentCruiseTime = max([(altCruise - 1/2*AscentAcc*AscentAccTime^2)/AscentSpeed,0]);
        AscentAccThrust = 1/2*rho*AscentSpeed^2*.566 + mass*AscentAcc + W;
        AscentCruiseThrust = 1/2*rho*AscentSpeed^2*.566 + W;
        
        % Calculate acceleration energy
        
        AscentAccEnergy = integral(@(t) powerCorrection(N_lift*lifterPower(AscentAccThrust/N_lift,AscentAcc*t,pi/2)),0,AscentAccTime);
        
        % Angle is pi/2 because thrust is aligned with flow direction
        
        % Calculate hover energy until desired height achieved
        AscentCruiseEnergy = integral(@(t) ...
            powerCorrection(N_lift*ones(size(t))*lifterPower(AscentCruiseThrust/N_lift,AscentSpeed,pi/2)),0,AscentCruiseTime);
        
        AscentEnergySearch(ind1,ind2) = AscentAccEnergy + AscentCruiseEnergy;
        
    end
end

figure(1)

[X,Y] = meshgrid(AscentSpeedList,AscentAccList);
surf(X,Y,AscentEnergySearch');
title('Energy consumption of different acceleration profiles','interpreter','latex')
xlabel('Ascent Steady Speed $\frac{m}{s}$','interpreter','Latex')
ylabel('Ascent Acceleration $\frac{m}{s^2}$','interpreter','Latex')
zlabel('Consumed Energy','interpreter','Latex')

AscentEnergy = min(AscentEnergySearch,[],'all');

[I,J] = ind2sub(size(AscentEnergySearch),find(AscentEnergySearch == AscentEnergy));
AscentSpeed = AscentSpeedList(I);
AscentAcc = AscentAccList(J);

AscentTime = AscentSpeed/AscentAcc + (altCruise - 1/2*AscentAcc*(AscentSpeed/AscentAcc)^2)/AscentSpeed;

line(AscentSpeed,AscentAcc,AscentEnergy,'marker','o','color',[1,0,0],'MarkerFaceColor',[1 0 0]);

%% Steady State Cruise Speed
% Pre calculate optimum cruise speed

CruiseAoAList = deg2rad(linspace(-4,10,30));

for ind1 = 1:length(CruiseAoAList)
    CruiseAoA = CruiseAoAList(ind1);
    
    MaxCruiseSpeed(ind1) = fzero(@(V) Lift(V,CruiseAoA) - W,30);
    
    %     if MaxCruiseSpeed(ind1) > 27
    %        continue
    %     end
    
    % Check Speeds up to cruise speed for a given AoA
    CruiseSpeedList(ind1,:) = linspace(1,MaxCruiseSpeed(ind1),100);
    
    for ind2 = 1:length(CruiseSpeedList)
        
        CruiseSpeed = CruiseSpeedList(ind1,ind2);
        
        CruiseLiftDeficit = W - Lift(CruiseSpeed,CruiseAoA);
        
        % Sanitizes Calculation Results
        if abs(CruiseLiftDeficit)<1e-10
            CruiseLiftDeficit = 0;
        end
        
        CruiseThrottle = sqrt(CruiseLiftDeficit/(N_lift*TMax));
        
        if ind2 == length(CruiseSpeedList)
            CruisePower(ind1,ind2) = powerCorrection(N_thrust*...
                thrusterPower(Drag(CruiseSpeed,CruiseAoA,CruiseThrottle)/N_thrust,CruiseSpeed,CruiseAoA));
        else
            % angle is negative because positive angle brings propeller
            % more aligned with freestream
            CruisePower(ind1,ind2) = powerCorrection(N_lift*lifterPower(CruiseLiftDeficit/N_lift,CruiseSpeed,-CruiseAoA)...
                + N_thrust*thrusterPower(Drag(CruiseSpeed,CruiseAoA,CruiseThrottle)/N_thrust,CruiseSpeed,CruiseAoA));
        end
        
        CruiseEffectiveDrag(ind1,ind2) = CruisePower(ind1,ind2)/CruiseSpeed;
    end
    
end

figure(2)

% Plot results
surf(rad2deg(repmat(CruiseAoAList',[1,length(CruiseSpeedList)])),CruiseSpeedList,CruiseEffectiveDrag)
title('Power consumption of different cruise configurations','interpreter','Latex')
xlabel('Angle of Attack (deg)','interpreter','Latex')
ylabel('Cruise Speed $\frac{m}{s}$','interpreter','Latex')
zlabel('Power/Speed','interpreter','Latex')

CruiseEffectiveDragMin = min(CruiseEffectiveDrag,[],'all');
[I,J] = ind2sub(size(CruiseEffectiveDrag),find(CruiseEffectiveDrag == CruiseEffectiveDragMin));
CruiseAoA = CruiseAoAList(I);
CruiseSpeed = CruiseSpeedList(I,J);

line(rad2deg(CruiseAoA),CruiseSpeed,CruiseEffectiveDragMin,'marker','o','color',[1,0,0],'MarkerFaceColor',[1 0 0]);

%% Acceleration

AccAoAList = CruiseAoAList;

% Calculate Max Speeds at each angle of attack to check if acceleration is
% possible

options = optimoptions('fsolve','Display','none');
T = @(V) fsolve(@(T) T/2*(V + sqrt(V.^2 + 2*T/(rho*A_prop))) - TMax^(3/2)/sqrt(2*rho*A_prop),TMax,options);
for ind1 = 1:length(AccAoAList)
    Vmax(ind1) = fsolve(@(V) 2*T(V)*cos(AccAoAList(ind1)) - Drag(V,AccAoAList(ind1),0),30,options);
end

figure(3)
plot(rad2deg(CruiseAoAList),Vmax,'k')
xlabel('Angle of Attack (deg)','interpreter','latex')
ylabel('Max Speed $\frac{m}{s}$','interpreter','latex')

% Aim for level flight
% Accelerate to desired cruise speed
for ind1 = 1:length(AccAoAList)
    
    if Vmax(ind1) > CruiseSpeed
              
        f = @(t,x) [x(2),(N_thrust*T(x(2)) - Drag(x(2),AccAoAList(ind1),sqrt(max([0,(W - Lift(x(2),AccAoAList(ind1)))])/(N_lift*TMax))))/mass]';
        
        [t,x]  = ode45(f,[0,100],[0,0]');
        AccCruiseSpeedIndex = find(x(:,2)>CruiseSpeed,1);
        [t,x]  = ode45(f,[0,t(AccCruiseSpeedIndex)+1],[0,0]');
        AccCruiseSpeedIndex = find(x(:,2)>CruiseSpeed,1);
           
        AccSpeedProfile = @(tSample) interp1(t,x(:,2),tSample);
        
        AccLifterThrust = @(tSample) interp1(t(1:AccCruiseSpeedIndex),(W - Lift(x(1:AccCruiseSpeedIndex,2),AccAoAList(ind1)))/N_lift,tSample);
        
        AccFinishTime = fzero(@(t) AccSpeedProfile(t) - CruiseSpeed,t(AccCruiseSpeedIndex-1));
        
        AccLifterTotalPower = @(tSample) N_lift*lifterPower(...
            max([zeros(size(AccLifterThrust(tSample))),AccLifterThrust(tSample)]),...
            interp1(t(1:AccCruiseSpeedIndex),x(1:AccCruiseSpeedIndex,2),tSample),-AccAoAList(ind1));
        
        AccEnergy(ind1) = integral(@(tSample)...
            powerCorrection(N_thrust*thrusterPower(TMax,AccSpeedProfile(tSample),AccAoAList(ind1)) + AccLifterTotalPower(tSample)),0,AccFinishTime);
        
    else
        AccEnergy(ind1) = 1e10;
    end
end

[AccEnergyMin,I] = min(AccEnergy);

figure(4)

plot(rad2deg(AccAoAList(AccEnergy<1e7)),AccEnergy(AccEnergy<1e7),'k')
xlabel('Angle of Attack (deg)')
ylabel('Energy Required for Acceleration (J)')

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

HoverTime = 0; %s

HoverPower = N_lift*lifterPower(W/N_lift,0,pi/2);

HoverEnergy = powerCorrection(HoverPower)*HoverTime;

%% Calculate cruise range from remaining capacity

CalculatedRange = (capacity - (AscentEnergy+AccEnergyMin+DeccEnergy+DescentEnergy+HoverEnergy))/CruiseEffectiveDragMin; %m

CruiseEnergy = CruiseEffectiveDragMin*CalculatedRange;

%% Display Results

disp(['Ascent:' num2str(AscentEnergy/capacity*100) '%'])

disp(['Acceleration:' num2str(AccEnergyMin/capacity*100) '%'])

disp(['Cruise:' num2str(CruiseEnergy/capacity*100) '%'])

disp(['Deceleration:' num2str(DeccEnergy/capacity*100) '%'])

disp(['Descent:' num2str(DescentEnergy/capacity*100) '%'])

disp(['Hover:' num2str(HoverEnergy/capacity*100) '%'])

disp(['Range:', num2str(CalculatedRange/1000), 'km'])


