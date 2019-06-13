CruiseAoAList = deg2rad(linspace(-4,10,50));


for ind1 = 1:length(CruiseAoAList)
CruiseAoA = CruiseAoAList(ind1);
    
    
    CruiseSpeedList(ind1,:) = linspace(1,35,50);

    
    for ind2 = 1:length(CruiseSpeedList)
        
        CruiseSpeed = CruiseSpeedList(ind1,ind2);
        
        CruiseEffectiveDragSearch(ind1,ind2) = cruiseCostFunction(CruiseAoA,CruiseSpeed);
        
    end
    
end



surf(rad2deg(repmat(CruiseAoAList',[1,length(CruiseSpeedList)])),CruiseSpeedList,CruiseEffectiveDragSearch)
title('Power consumption of different cruise configurations','interpreter','Latex')
xlabel('Angle of Attack (deg)','interpreter','Latex')
ylabel('Cruise Speed $\frac{m}{s}$','interpreter','Latex')
zlabel('Power/Speed','interpreter','Latex')
zlim([60,400])