clear
close all


b = 2;
U = 10; % forward flight speed m/s
Alpha = .1; % geometric angle of attack radians


theta_y = @(y) acos(y/(b/2));
theta_xi = @(xi) acos(xi);
y_theta = @(theta) b/2*cos(theta);

c = @(y) .1*ones(size(y));

S = integral(c,-b/2,b/2);
AR = b^2/S;
cbar = S/b;

Wing.AR = AR;
Wing.c_cbar = @(theta) c(y_theta(theta))/cbar;  
Wing.Alpha = Alpha;

n = 39;
nList = (1:2:n)';

[B_n,oswald_e,C_L,C_Di,b_n] = liftingLineEvaluate(Wing,nList);

fi = 0;

% Span Loading
fi = fi+1;
figure(fi)
clf

xiSample = linspace(-1,1,10001)';
A_1 = (4/(AR+2))*Alpha; % Elliptical coefficient for reference
plot(xiSample,A_1*sin(theta_xi(xiSample))*2*AR,'color',[0 0 0],'linestyle',':')
hold on
plot(xiSample,GammaF(nList,B_n,theta_xi(xiSample))*2*AR,'color',[0 0 0],'linestyle','-');
xlabel('$y/(b/2)$','interpreter','latex')
ylabel('$2 \Gamma/(U_\infty \overline{c})$','interpreter','latex')
title('Span Loading $K$','interpreter','latex')
grid on
legend('Elliptical','Wing','interpreter','latex','location','best')


% Net downwash
fi = fi+1;
figure(fi)
clf

plot(xiSample,rad2deg(epsilonF(1,A_1,theta_xi(xiSample))),'color',[0 0 0],'linestyle',':')
hold on
plot(xiSample,rad2deg(epsilonF(nList,B_n,theta_xi(xiSample))),'color',[0 0 0],'linestyle','-')

load('data.mat')
plot(data(1,:)/(b/2),-rad2deg(atan2(-data(2,:),10)),'color',[0 0 0],'linestyle','--')

xlabel('$y/(b/2)$','interpreter','latex')
ylabel('$\varepsilon(\xi)$','interpreter','latex')
title('Downwash angle on Wing','interpreter','latex')
grid on
legend('Elliptical','Wing','Free Vortex Wing','interpreter','latex','location','best')

