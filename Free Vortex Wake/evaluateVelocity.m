clear
close all

load('SimulationOutput.mat')

xList = .1:-.1:-1.5;
zList = -.2:.1:.2;
n = 101;

for ind2 = 1:length(zList)
    zSample = zList(ind2);
    for ind1 = 1:length(xList)
        
        samplePoints = [xList(ind1)*ones(1,n);linspace(-2,2,n);zSample*ones(1,n)];
        V = sampleVelocity(simulation,samplePoints);
        
        line(xList(ind1)*ones(1,n),samplePoints(2,:)',V(3,:)'+zSample*ones(1,n),'color',[0 0 0])
        hold on
        
    end
end
grid on
set(gca,'ZDir','reverse')
view([45,45])