clear
close all

P0 = 101325; % Sea Level Pressure
g = 9.80665; % Gravity acceleration

M = .0289644; % Molar mass of air
R = 8.31432; % Universal gas constant

h0 = 0;
h = 1000;

T = 15+273.15;

P = P0*exp(-g*M*(h-h0)/(R*T));