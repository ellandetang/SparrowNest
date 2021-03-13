function body = updateBody(body,simulation)
% Takes simulation state and updates each body and propagate the states
% forward in time
for indB = 1:length(body)
    
    % From present filaments, calculate new vorticities on the wing
    body(indB).VInducedFixed = batchBiotSavart_mex(simulation.startPoints(:,simulation.selectedFilaments),simulation.endPoints(:,simulation.selectedFilaments),...
        simulation.Gamma(:,simulation.selectedFilaments),simulation.Rc(:,simulation.selectedFilaments),body(indB).FixedSamplePoints);
    body = calculateGamma(body,simulation,indB);
    
    % Propagate the vorticities along the filament
    for ind1 = 1:body(indB).nWingSegments+1
        body(indB).FreeGamma(body(indB).targetIndices(ind1)+(1:body(indB).nFilamentSegments-1)) = ...
            body(indB).FreeGamma(body(indB).targetIndices(ind1)+(0:body(indB).nFilamentSegments-2));
    end
    
    % Propagate the new vorticities to the filament
    body(indB).FreeGamma(body(indB).targetIndices) = -diff([0,body(indB).FixedGamma,0]);
    
    % Propagate vorticity along the cross filaments
    for ind2 = 1:body(indB).nWingSegments
        body(indB).CrossGamma(body(indB).targetIndices(ind2)+(1:body(indB).nFilamentSegments-1)) =...
            body(indB).CrossGamma(body(indB).targetIndices(ind2)+(0:body(indB).nFilamentSegments-2));
    end
    
    %body(indB).CrossGamma(body(indB).targetIndices(1:end-1)) = body(indB).FixedGamma_Old - body(indB).FixedGamma;
    body(indB).CrossGamma(:) = 0;
    
    % Calculate Induced Velocities
    VInduced = batchBiotSavart_mex(...
        simulation.startPoints(:,simulation.selectedFilaments),simulation.endPoints(:,simulation.selectedFilaments),...
        simulation.Gamma(:,simulation.selectedFilaments),simulation.Rc(:,simulation.selectedFilaments),body(indB).FreeStartPoints);
    
    % Calculate timestepped vortex point locations (Forward Euler)
    FreeUpdate = body(indB).FreeStartPoints + simulation.dt*(VInduced + repmat(simulation.U,[1,size(VInduced,2)]));
    
    % Reassign filament locations
    body(indB).FreeEndPoints = FreeUpdate;
    
    % Store Filament Positions
    % body(indB).FreeEndPointsStore(:,:,end+1) = body(indB).FreeEndPoints; %
    
    % Shift filament indices
    for ind3 = 1:body(indB).nWingSegments+1
        body(indB).FreeStartPoints(:,body(indB).targetIndices(ind3)+(1:body(indB).nFilamentSegments-1)) =...
            FreeUpdate(:,body(indB).targetIndices(ind3)+(0:body(indB).nFilamentSegments-2));
    end
    
    % Adjust Cross Vorticity Locations
    body(indB).CrossStartPoints = body(indB).FreeEndPoints(:,1:end-body(indB).nFilamentSegments);
    body(indB).CrossEndPoints = body(indB).FreeEndPoints(:,(body(indB).nFilamentSegments+1):end);
    
    
    % Move body per programmed motion    
    body(indB).FixedStartPoints = transformPoints(body(indB).motion_T(simulation.time),...
        body(indB).motion_R(simulation.time),...
        body(indB).motion_V(simulation.time),...
        body(indB).motion_Om(simulation.time),body(indB).FixedStartPoints_0);
    body(indB).FixedEndPoints = transformPoints(body(indB).motion_T(simulation.time),...
        body(indB).motion_R(simulation.time),...
        body(indB).motion_V(simulation.time),...
        body(indB).motion_Om(simulation.time),body(indB).FixedEndPoints_0);
    [body(indB).FixedSamplePoints, body(indB).FixedSamplePoints_V] = transformPoints(body(indB).motion_T(simulation.time),...
        body(indB).motion_R(simulation.time),...
        body(indB).motion_V(simulation.time),...
        body(indB).motion_Om(simulation.time),body(indB).FixedSamplePoints_0);
    body(indB).sectionX = transformPoints(body(indB).motion_T(simulation.time),...
        body(indB).motion_R(simulation.time),...
        body(indB).motion_V(simulation.time),...
        body(indB).motion_Om(simulation.time),body(indB).sectionX_0);
    body(indB).sectionY = transformPoints(body(indB).motion_T(simulation.time),...
        body(indB).motion_R(simulation.time),...
        body(indB).motion_V(simulation.time),...
        body(indB).motion_Om(simulation.time),body(indB).sectionY_0);

    
    body(indB).FreeStartPoints(:,body(indB).targetIndices) = [body(indB).FixedStartPoints, body(indB).FixedEndPoints(:,end)];
    
end

end

