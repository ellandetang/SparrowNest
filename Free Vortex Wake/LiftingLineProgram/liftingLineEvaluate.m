function [B_n,oswald_e,C_L,C_Di,b_n] = liftingLineEvaluate(Wing,nList)
% Calculates properties of an untwisted wing with prandtl lifting line
% theory

% note: y/(b/2) = cos(theta)


% Inputs
% Wing is a struct with the following properties:
% AR   Wing aspect ratio 
% c_cbar chord distribution, function of theta
% Alpha Wing angle of attack, radians

% nList coefficient list for circulation fourier series

% Outputs
% B_n Circulation function coefficients as defined by Gamma(theta) = U_inf*b*SUM_n(B_n sin(n theta))
% oswald_e Oswald Efficiency number
% C_L Wing lift coefficient L = 1/2 rho V^2 A C_L
% C_Di Induced Drag Coefficient 
% b_n non-dimensional Circulation Fourier series coefficients

% Craft Parameters
AR = Wing.AR;
cbar_b = 1/AR;
a_0 = 2*pi;
c_cbar = Wing.c_cbar;
Alpha = Wing.Alpha;


% Number of terms for Circulation Function
n = length(nList);

% Functions for each variable solution
q = @(theta,n) sin(n.*theta) + 1/4.*a_0.*c_cbar(theta)./AR.*n.*sin(n.*theta)./sin(theta);
r = @(theta) 1/2*a_0.*c_cbar(theta)./AR;

ASystem = zeros(n);
bSystem = zeros(n,1);

for ind1 = 1:n
    m = nList(ind1);
    for ind2 = 1:n
        ASystem(ind1,ind2) = integral(@(theta) q(theta,m).*q(theta,nList(ind2)),0,pi);
    end
    bSystem(ind1) = integral(@(theta) q(theta,m).*r(theta),0,pi);
end

b_n = ASystem\bSystem;

C_L =  (pi/2*AR)*Alpha*b_n(1);

B_n = b_n*Alpha;

oswald_e = 1./sum(nList.*((B_n)./B_n(1)).^2);
% keyboard
C_Di = 1/(pi*AR*oswald_e)*C_L^2;

end


