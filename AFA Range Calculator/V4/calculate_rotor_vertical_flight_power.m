function [P, vi] = calculate_rotor_vertical_flight_power(T, Vc, rho, A)
% T is thrust
% Vc is the cruise speed
% Rho is density
% A is propeller disk area

vh = sqrt(T./(2.*rho.*A)); % induced speed at hover
Ph = T.^(3/2)./sqrt(2*rho*A); % induced power at hover

if Vc < 0
    error('function does not support descent yet');
elseif Vc == 0
    vi = vh;
    P = Ph;
    return;
else
    vi_vh = -(Vc./(2*vh)) + sqrt( (Vc./(2*vh)).^2 + 1);
    vi = vh .* vi_vh; % induced speed
    P_Ph = Vc./vh + vi_vh;
    P = Ph .* P_Ph; % induced power;
    return;
end
end