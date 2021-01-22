function [] = plotResults(body)

GammaMax = 0;

for indB = 1:length(body)
    Gamma = [body(indB).FixedGamma,body(indB).FreeGamma,body(indB).CrossGamma];
    GammaSup = max(abs(Gamma));
    if GammaSup>GammaMax
        GammaMax = GammaSup;
    end
    GammaScaleF = @(in) interp1([0 GammaMax],[0,1],abs(in));
end

for indB = 1:length(body)
    
    % Plot trailing vortices
    for ind1 = 1:(body(indB).nWingSegments+1)       
        filamentStart = body(indB).FreeStartPoints(:,body(indB).targetIndices(ind1)+(0:body(indB).nFilamentSegments-1));
        filamentEnd = body(indB).FreeEndPoints(:,body(indB).targetIndices(ind1)+(0:body(indB).nFilamentSegments-1));
        filamentGamma = body(indB).FreeGamma(body(indB).targetIndices(ind1)+(0:body(indB).nFilamentSegments-1));
        for ind3 = 1:size(filamentStart,2)
            line([filamentStart(1,ind3),filamentEnd(1,ind3)]',...
                [filamentStart(2,ind3),filamentEnd(2,ind3)]',...
                [filamentStart(3,ind3),filamentEnd(3,ind3)]',...
                'marker','.','markersize',5,...
                'linewidth',.5,...
                'color',[1-GammaScaleF(filamentGamma(ind3)),0,GammaScaleF(filamentGamma(ind3))]);
        end       
    end
    
    % Plot cross vortex points
    for ind2 = 1:size(body(indB).CrossStartPoints,2)
        line([body(indB).CrossStartPoints(1,ind2),body(indB).CrossEndPoints(1,ind2)]',...
            [body(indB).CrossStartPoints(2,ind2),body(indB).CrossEndPoints(2,ind2)]',...
            [body(indB).CrossStartPoints(3,ind2),body(indB).CrossEndPoints(3,ind2)]',...
            'marker','.','markersize',5,...
            'linewidth',.5,...
            'color',[1-GammaScaleF(body(indB).CrossGamma(ind2)),0,GammaScaleF(body(indB).CrossGamma(ind2))]);
    end
    
    % Plot wing points
    for ind3 = 1:size(body(indB).FixedStartPoints,2)
        line([body(indB).FixedStartPoints(1,ind3),body(indB).FixedEndPoints(1,ind3)]',...
            [body(indB).FixedStartPoints(2,ind3),body(indB).FixedEndPoints(2,ind3)]',...
            [body(indB).FixedStartPoints(3,ind3),body(indB).FixedEndPoints(3,ind3)]',...
            'marker','.','markersize',5,...
            'linewidth',1,...
            'color',[0 0 0]);
    end
    
end

view(45,45)
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on
% axis equal
zlim([-.5,.5])
ax = gca;
set(ax,'YDir','reverse','ZDir','reverse');

end