clear
close all
clc

% Craft Parameters
AR = 10;
cbar_b = 1/AR;
a_0 = 2*pi;
lambda = .5;
c_cbar = @(theta) ((1 + lambda) - 2*lambda*abs(cos(theta)));
C_L_ref = .727;

Craft.AR = AR;
Craft.lambda = lambda;
Craft.C_L_ref = C_L_ref;

% Transformation functions
theta = @(xi) acos(xi);

v_U1 = @(in) zeros(size(in));

n1 = 39;
nList1 = (1:2:n1)';


[A_n,alpha_ref1,oswald_e1,C_Di1,C_M1] = liftingLineEvaluate(Craft,nList1,v_U1,0,0);

% Analytic method
Gamma_0_Ub = sum(A_n.*sin(nList1*pi/2));
s = pi/4*A_n(1)./Gamma_0_Ub;
r_c = s*1/exp(s^2/oswald_e1*4+1/2);

r1 = @(xi) xi - s/2;
r2 = @(xi) xi + s/2;
v_U2 = @(xi) Gamma_0_Ub/(2*pi)*(r1(xi)./(r1(xi).^2 + r_c^2) - r2(xi)./(r2(xi).^2 + r_c^2));

n2 = 40;
nList2 = (1:n2)';
delta_a = 0;

d_sList = linspace(.5,2,50);
C_DiList = zeros(size(d_sList));

for ind1 = 1:length(d_sList)
    
    d_s = d_sList(ind1);
    
    C_DiList(ind1) = costF(d_s,Craft,nList2,v_U2);
    
end

plot(d_sList,C_DiList,'color',[0 0 0])
line(d_sList,C_Di1*ones(size(d_sList)),'linestyle','--','color',[0 0 0])
grid on

xlabel('$d_s$','interpreter','latex')
ylabel('$C_{D_i}$','interpreter','latex')
legend('$C_{D_i}$','$C_{D_{i0}}$','interpreter','latex')

function C_Di = costF(d_s,Craft,nList,v_U)
% Loop for calculating induced drag based upon separation distance using a
% simplified function


AR = Craft.AR;
C_L_ref = Craft.C_L_ref;
theta = @(xi) acos(xi);

[~,alpha_ref2,~,~,~,b_n,c_n,d_n] = liftingLineEvaluate(Craft,nList,v_U,d_s,0);

MomentC1 = 1/2/AR*integral(@(theta) GammaF(nList,(b_n*alpha_ref2 + c_n),theta).*sin(theta).*cos(theta),0,pi);
MomentC2 = 1/2/AR*integral(@(theta) GammaF(nList,d_n,theta).*sin(theta).*cos(theta),0,pi);

delta_aTrim = -MomentC1/MomentC2;

alpha_ref = (C_L_ref/(pi/2*AR) - (c_n(1) + d_n(1)*delta_aTrim))/b_n(1);
B_n2 = b_n*alpha_ref + c_n + d_n*delta_aTrim;
oswald_e = 1./sum(nList.*((B_n2)./B_n2(1)).^2);
C_Di = 1/(pi*AR*oswald_e)*C_L_ref^2 - AR*integral(@(xi) v_U(xi + d_s).*GammaF(nList,B_n2,theta(xi)),-1,1);

end
