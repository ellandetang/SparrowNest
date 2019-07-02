function P = calculate_rotor_profile_power(Vinf, rho, Omega, R, sigma, Cd0)
% if nargin < 6
%     Cd0 = 0.01;
% end

mu = Vinf./(Omega.* R); % advance ratio
if sum(Omega==0) ~= 0
    mu(Omega==0) = zeros(1,sum(Omega==0));
end

K  = 4.7; % From Stepniewski (1973)
A  = pi * R.^2;

CP0 = (sigma .* Cd0/8 ) .* (1 + K * mu.^2);

P = CP0 .* (rho.* A .* Omega.^3.* R.^3);

end