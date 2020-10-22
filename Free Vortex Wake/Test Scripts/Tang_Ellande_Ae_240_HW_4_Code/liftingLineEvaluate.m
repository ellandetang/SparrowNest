function [B_n,alpha_ref,oswald_e,C_Di,C_M,b_n,c_n,d_n] = liftingLineEvaluate(Craft,nList,v_U,d_s,delta_a)
% v_U is local angle of attack induced by a vertical field expressed as a
% function handle as a function of xi
% d_s is the position of the center of the follower craft relative to the
% center of the leader craft
% delta_a is the aileron deflection angle
% C_L_ref is the reference CL to match

% Craft Parameters
AR = Craft.AR;
cbar_b = 1/AR;
a_0 = 2*pi;
lambda = Craft.lambda;
c_cbar = @(theta) ((1 + lambda) - 2*lambda*abs(cos(theta)));

C_L_ref = Craft.C_L_ref;

% location of trailer aircraft center d_i/(b/2)
% d_s = 1+s/2;
% d_s = 2;

% Transformation functions
theta = @(xi) acos(xi);

% Aileron Deflection function
tau = .05;
f = @(xi) (Heaviside(xi - .7) - Heaviside(xi - .9)) + (Heaviside(xi + .7) - Heaviside(xi + .9));

% Number of terms for Circulation Function
% nList = (1:n)';
n = length(nList);

% Functions for each variable solution
q = @(theta,n) sin(n.*theta) + 1/4.*a_0.*c_cbar(theta)./AR.*n.*sin(n.*theta)./sin(theta);
r_b = @(theta) 1/2*a_0.*c_cbar(theta)./AR;
r_c = @(theta) r_b(theta).*(v_U(cos(theta) + d_s));
r_d = @(theta) r_b(theta).*tau.*f(cos(theta));

ASystem = zeros(n);
bSystem_c = zeros(n,1);
bSystem_b = zeros(n,1);
bSystem_d = zeros(n,1);

for ind1 = 1:n
    m = nList(ind1);
    for ind2 = 1:n
        ASystem(ind1,ind2) = integral(@(theta) q(theta,m).*q(theta,nList(ind2)),0,pi);
    end
    bSystem_b(ind1) = integral(@(theta) q(theta,m).*r_b(theta),0,pi);
    bSystem_c(ind1) = integral(@(theta) q(theta,m).*r_c(theta),0,pi);
    bSystem_d(ind1) = integral(@(theta) q(theta,m).*r_d(theta),0,pi);
end

b_n = ASystem\bSystem_b;
c_n = ASystem\bSystem_c;
d_n = ASystem\bSystem_d;

alpha_ref = (C_L_ref/(pi/2*AR) - (c_n(1) + d_n(1)*delta_a))/b_n(1);

B_n = b_n*alpha_ref + c_n + d_n*delta_a;

oswald_e = 1./sum(nList.*((B_n)./B_n(1)).^2);
% keyboard
C_Di = 1/(pi*AR*oswald_e)*C_L_ref^2 - AR*integral(@(xi) v_U(xi + d_s).*GammaF(nList,B_n,theta(xi)),-1,1);

C_M = 1/2/AR*integral(@(theta) GammaF(nList,B_n,theta).*sin(theta).*cos(theta),0,pi);

end

