function [P, vi] = calculate_rotor_forward_flight_power(T, Vinf ,alpha, rho, A)
% Solves for power associated with a lifting rotor in forward flight

vh = sqrt(T./(2.*rho.*A)); % induced speed at hover
vh = vh .* ones(size(Vinf)) .* ones(size(alpha));


solvefun = @(vi) T -  2 .* rho .* A .* vi .* sqrt( (Vinf .* cos(alpha)).^2 + (Vinf.*sin(alpha) + vi).^2);
% options = optimoptions('fsolve','Display','none','PlotFcn',@optimplotfirstorderopt);
options = optimoptions('fsolve','Display','none');

[visol, ~, ~] = fsolve(solvefun, vh, options);

vi = visol;
P = T .* (Vinf .* sin(alpha) + vi);
end