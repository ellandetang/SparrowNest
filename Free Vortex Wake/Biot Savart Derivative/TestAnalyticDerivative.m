clear
close all


BList = linspace(1.5,2.5,100);


K = 1/(4*pi);

for ind1 = 1:length(BList)
    B = BList(ind1);
    filamentStart = [0 0 0]';
    filamentEnd = [B 0 0]';
    
    samplePoint = [1,1,0]';
    
    
    V = batchBiotSavart_mex(filamentStart,filamentEnd,1,0,samplePoint);
    VList(ind1) = V(3);
    
    
    A = filamentStart(1:2);
    B = filamentEnd(1:2);
    P = samplePoint(1:2);
    V2 = K*(1./P(2)).*(P(1)./sqrt(sum((P-A).^2)) - (P(1) - B(1))./sqrt(sum((P-B).^2)));
    VList2(ind1) = V2;
end

dV = VList(3:end) - VList(1:end-2);
dB = BList(3:end) - BList(1:end-2);
dV_dB = dV./dB;

subplot(2,1,1)
plot(BList,VList)
grid on
hold on
plot(BList,VList2)

subplot(2,1,2)
plot(BList(2:end-1),dV_dB)
grid on
hold on


dV_dB_Anal = K*(1./P(2)).*(1./sqrt((P(1) - BList).^2 + P(2).^2)  - (P(1) - BList).^2./(((P(1) - BList).^2 + P(2).^2).^(3/2)));
plot(BList,dV_dB_Anal)

