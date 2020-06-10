clear
close all
clc

load('AlignedData.mat')
load('baseline.mat')

for ind1 = 1:length(RPMMatrix)
%     line(Data{3,ind2},Data{7,ind2},'marker','o','linestyle','none')
    
    xData = RPMMatrix{ind1}/60*2*pi;
      
    yData = ThrustMatrix{ind1}/1000*9.81;
    
    CT(ind1) = (xData.^2*D^4*rho)\yData;
    
    yData = TorqueMatrix{ind1};
    
    CQ(ind1) = (xData.^2*D^5*rho)\yData;
    
    yData = ForceMatrix{ind1}/1000*9.81;
    
    dataLength = length(yData);
    
    CF(ind1) = (xData(1:floor(dataLength/2)).^2*D^4*rho)\yData(1:floor(dataLength/2));
    
    % Check quadratic fit of data
    xSample = linspace(0,max(xData)*1.1);
    plot(xData,yData,'.',xSample,xSample.^2*D^4*rho*CF(ind1))
    keyboard
    
    % yData = (ForceMatrix{ind1}+ThrustMatrix{ind1})/1000*9.81;
    
    % CC(ind1) = (xData.^2*D^4*rho)\yData;
    CC(ind1) = CT(ind1) + CF(ind1);
    
end

d_D = positionX*.0254/D;

standardOptions = {'marker','o','markersize',3,'linestyle','--','color',[0 0 0]};

figure(1)
subplot(2,1,1)
line(d_D,CT/CT_Baseline,standardOptions{:},'linestyle',':')
line(d_D,CF/CT_Baseline,standardOptions{:},'marker','^','linestyle',':')
line(d_D,(CC)/CT_Baseline,standardOptions{:},'marker','square')
xlabel('$d/D$','interpreter','latex')
ylabel('$C_F/C_{T_Baseline}$','interpreter','latex')
grid on
legend('Propeller','Obstructing Surface','Combined','location','best')

subplot(2,1,2)
line(d_D,CQ/CQ_Baseline,standardOptions{:})
xlabel('$d/D$','interpreter','latex')
ylabel('$C_Q/C_{Q_Baseline}$','interpreter','latex')
grid on

figure(2)
subplot(2,1,1)
line(d_D,CC./CQ,standardOptions{:})
xlabel('$d/D$','interpreter','latex')
ylabel('$C_F/C_Q$','interpreter','latex')
grid on

subplot(2,1,2)
line(d_D,(CC./CQ)/(CT_Baseline/CQ_Baseline),standardOptions{:})
xlabel('$d/D$','interpreter','latex')
ylabel('$(C_F/C_Q)/(C_T/C_Q)_Baseline$','interpreter','latex')
grid on


% plot(RPMMatrix(:,1),[ThrustMatrix(:,1) -forceMeasured(:,1)])
save('20200130bData','d_D','CC','CF','CQ','CT')