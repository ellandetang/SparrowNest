function [Padj] = adjusted_Electric_Energy_Consumption(P, C, eta, Rt, n)
% Calculates Electric Energy Consumption Based on Power Draw
% For the inspiration, see Traub, L. W. (2011). Range and Endurance Estimates for 
% Battery-Powered Aircraft

% P is an array of power consumptions in Watts 

% C is energy capacity in Joules

% eta is the power draw efficiency 

% Rt is the time span against which the battery capacity was rated in hours
% (typ 1h)

% n is the discharge parameter for the battery, based on type and temp. typ
% 1.3 for Lipo

Padj = (Rt*3600).^(n-1).*(P/eta).^n.*C^(1-n);


end

