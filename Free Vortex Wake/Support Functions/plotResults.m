function [] = plotResults(body)
Gamma = [body(1).FixedGamma,body(1).FreeGamma,body(1).CrossGamma];
GammaMax = max(abs(Gamma));
GammaScaleF = @(in) interp1([0 GammaMax],[0,1],abs(in));
for ind1 = 1:(body(1).nWingSegments+1)
    
    filamentStart = body(1).FreeStartPoints(:,body(1).targetIndices(ind1)+(0:body(1).nFilamentSegments-1));
    filamentEnd = body(1).FreeEndPoints(:,body(1).targetIndices(ind1)+(0:body(1).nFilamentSegments-1));
    filamentGamma = body(1).FreeGamma(body(1).targetIndices(ind1)+(0:body(1).nFilamentSegments-1));
    for ind3 = 1:size(filamentStart,2)
        line([filamentStart(1,ind3),filamentEnd(1,ind3)]',...
            [filamentStart(2,ind3),filamentEnd(2,ind3)]',...
            [filamentStart(3,ind3),filamentEnd(3,ind3)]',...
            'marker','.','markersize',5,...
            'linewidth',.5,...
            'color',[1-GammaScaleF(filamentGamma(ind3)),0,GammaScaleF(filamentGamma(ind3))]);
    end
    
end

% Plot
for ind2 = 1:size(body(1).CrossStartPoints,2)
    line([body(1).CrossStartPoints(1,ind2),body(1).CrossEndPoints(1,ind2)]',...
        [body(1).CrossStartPoints(2,ind2),body(1).CrossEndPoints(2,ind2)]',...
        [body(1).CrossStartPoints(3,ind2),body(1).CrossEndPoints(3,ind2)]',...
        'marker','.','markersize',5,...
        'linewidth',.5,...
        'color',[1-GammaScaleF(body(1).CrossGamma(ind2)),0,GammaScaleF(body(1).CrossGamma(ind2))]);
end

% Plot wing points
for ind3 = 1:size(body(1).FixedStartPoints,2)
        line([body(1).FixedStartPoints(1,ind3),body(1).FixedEndPoints(1,ind3)]',...
            [body(1).FixedStartPoints(2,ind3),body(1).FixedEndPoints(2,ind3)]',...
            [body(1).FixedStartPoints(3,ind3),body(1).FixedEndPoints(3,ind3)]',...
            'marker','.','markersize',5,...
            'linewidth',1,...
            'color',[0 0 0]);
end
    

view(45,45)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
% axis equal
zlim([-1,1])
ax = gca;
set(ax,'YDir','reverse','ZDir','reverse');

end