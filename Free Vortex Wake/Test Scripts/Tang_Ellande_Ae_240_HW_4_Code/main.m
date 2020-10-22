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
% d_s = 1+s/2;
d_s = 1.303055127852941;
delta_a = 0;

[B_n1,alpha_ref2,oswald_e2,C_Di2,C_M2,b_n,c_n,d_n] = liftingLineEvaluate(Craft,nList2,v_U2,d_s,delta_a);  

% 1/2/AR*integral(@(theta) GammaF(nList,B_n,theta).*sin(theta).*cos(theta),0,pi);

MomentC1 = 1/2/AR*integral(@(theta) GammaF(nList2,(b_n*alpha_ref2 + c_n),theta).*sin(theta).*cos(theta),0,pi);
MomentC2 = 1/2/AR*integral(@(theta) GammaF(nList2,d_n,theta).*sin(theta).*cos(theta),0,pi);

delta_aTrim = -MomentC1/MomentC2;

% Fzero method
% delta_aTrim = fzero(@(in) fSelector(n2,v_U2,d_s,in,C_L_ref),0);

[B_n2,alpha_ref3,oswald_e3,C_Di3,C_M3] = liftingLineEvaluate(Craft,nList2,v_U2,d_s,delta_aTrim);  

%% Report Quantities

disp(rad2deg([alpha_ref1 alpha_ref2 alpha_ref3]'))

disp([oswald_e1,oswald_e2,oswald_e3]')

disp([C_Di1 C_Di2 C_Di3]')

disp([Gamma_0_Ub s r_c])

disp([C_M1 C_M2 C_M3]')

disp(delta_aTrim)

%% Plotting

xiSample = linspace(-1,1,10001)';

fi = 1;

% Span Loading
figure(fi)
clf

A_1 = (4/(AR+2))*alpha_ref1; % Elliptical coefficient for reference
plot(xiSample,A_1*sin(theta(xiSample))*2*AR,'color',[0 0 0],'linestyle',':')
hold on
plot(xiSample,GammaF(nList1,A_n,theta(xiSample))*2*AR,'color',[0 0 0],'linestyle','-');
plot(xiSample,GammaF(nList2,B_n1,theta(xiSample))*2*AR,'color',[0 0 0],'linestyle','--');
plot(xiSample,GammaF(nList2,B_n2,theta(xiSample))*2*AR,'color',[0 0 0],'linestyle','-.');
xlabel('$y/(b/2)$','interpreter','latex')
ylabel('$2 \Gamma/(U_\infty \overline{c})$','interpreter','latex')
title('Span Loading $K$','interpreter','latex')
grid on
legend('Elliptical','Leader Aircraft','Trailer-Untrimmed','Trailer-Trimmed','interpreter','latex','location','best')

fi = fi+1;

% Effective Angle of Attack
figure(fi)
clf

plot(xiSample,rad2deg(alpha_ref1 - 1/2*A_1*ones(size(xiSample))),'color',[0 0 0],'linestyle',':')
hold on
plot(xiSample,rad2deg(alpha_ref1 - epsilonF(nList1,A_n,theta(xiSample))),'color',[0 0 0],'linestyle','-')
plot(xiSample,rad2deg(alpha_ref2 + v_U2(xiSample + d_s) - epsilonF(nList2,B_n1,theta(xiSample))),'color',[0 0 0],'linestyle','--')
plot(xiSample,rad2deg(alpha_ref2 + v_U2(xiSample + d_s) - epsilonF(nList2,B_n2,theta(xiSample))),'color',[0 0 0],'linestyle','-.')
xlabel('$y/(b/2)$','interpreter','latex')
ylabel('$\alpha_e(\xi)$','interpreter','latex')
title('$\alpha_e(\xi) = \alpha(\xi) + \alpha_v(\xi) - \varepsilon(\xi)$','interpreter','latex')
grid on
legend('Elliptical','Leader Aircraft','Trailer-Untrimmed','Trailer-Trimmed','interpreter','latex','location','best')

fi = fi+1;

% Net downwash
figure(fi)
clf

plot(xiSample,rad2deg(epsilonF(nList2,B_n1,theta(xiSample)) - v_U2(xiSample+d_s)),'color',[0 0 0],'linestyle','-')
xlabel('$y/(b/2)$','interpreter','latex')
ylabel('$\varepsilon(\xi) - \alpha_v(\xi)$','interpreter','latex')
title('Net Downwash on Untrimmed Follower Craft','interpreter','latex')
grid on

fi = fi+1;

% Leader Wake
figure(fi)
clf

plot(xiSample*3,rad2deg(v_U2(xiSample*3)),'color',[0 0 0],'linestyle','-')
line([-1,1]+d_s,[0 0],'lineWidth',5,'color',[1 0 0])
xlabel('$y/(b/2)$','interpreter','latex')
ylabel('$v/U_{\infty}$ (deg)','interpreter','latex')
xlim([-3,3])
title('Wake of Leader and Position of Follower','interpreter','latex')
grid on

fi = fi+1;

% Diagnostic Plot
% figure(fi)
% clf
% 
% plot(xiSample,rad2deg(epsilonF(nList1,A_n,theta(xiSample))),'marker','.')
% xlabel('$y/(b/2)$','interpreter','latex')
% ylabel('$\varepsilon(\xi)$','interpreter','latex')
% grid on
% 
% fi = fi+1;