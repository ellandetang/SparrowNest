clear
close all

% Source: https://en.wikipedia.org/wiki/Density_of_air#Humid_air

phi = 1; % Relative humidity
p = 101325; % Measured Air Pressure
T = 15 + 273.15; % temperature in Kelvin

p_sat = 6.102*10.^(7.5*(T - 273.15)./(T - 273.15 + 237.8))*100;

p_v = phi*p_sat;

p_d = p - p_v;

R_d = 287.058; % Specific Gas Constant for dry air
R_v = 461.495; % Specific Gas Constant for water vapor

R = 8.314; % Universal Gas Constant

M_d = .028964; % Molar mass of dry air
M_v = .018016; % Molar mass of water vapor

% Two ways of calculating density
rho1 = p_d./(R_d*T) + p_v./(R_v*T);
rho2 = (p_d*M_d + p_v*M_v)./(R*T);



