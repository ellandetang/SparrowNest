function body = updateBody(body,simulation)
% Takes simulation state and update one body and propagate the states
% forward in time

% From present filaments, calculate new vorticities on the wing
    body(1).VInducedFixed = batchBiotSavart_mex(simulation.startPoints(:,simulation.selectedFilaments),simulation.endPoints(:,simulation.selectedFilaments),...
        simulation.Gamma(:,simulation.selectedFilaments),simulation.Rc(:,simulation.selectedFilaments),body(1).FixedSamplePoints);
    body = calculateGamma(body,simulation);
    
    % Propagate the vorticities along the filament
    for ind1 = 1:body(1).nWingSegments+1
        body(1).FreeGamma(body(1).targetIndices(ind1)+(1:body(1).nFilamentSegments-1)) = ...
        body(1).FreeGamma(body(1).targetIndices(ind1)+(0:body(1).nFilamentSegments-2));
    end
    
    % Propagate the new vorticities to the filament
    body(1).FreeGamma(body(1).targetIndices) = -diff([0,body(1).FixedGamma,0]);
    
    % Propagate vorticity along the cross filaments
    for ind2 = 1:body(1).nWingSegments
        body(1).CrossGamma(body(1).targetIndices(ind2)+(1:body(1).nFilamentSegments-1)) =...
        body(1).CrossGamma(body(1).targetIndices(ind2)+(0:body(1).nFilamentSegments-2));
    end
    
    body(1).CrossGamma(body(1).targetIndices(1:end-1)) = body(1).FixedGamma_Old - body(1).FixedGamma;
    
    % Calculate Induced Velocities
    VInduced = batchBiotSavart_mex(...
        simulation.startPoints(:,simulation.selectedFilaments),simulation.endPoints(:,simulation.selectedFilaments),...
        simulation.Gamma(:,simulation.selectedFilaments),simulation.Rc(:,simulation.selectedFilaments),body(1).FreeStartPoints);
    
    % Calculate timestepped vortex point locations (Forward Euler)
    FreeUpdate = body(1).FreeStartPoints + simulation.dt*(VInduced + repmat(simulation.U,[1,size(VInduced,2)]));
    
    % Reassign filament locations
    body(1).FreeEndPoints = FreeUpdate;
    
    % Store Filament Positions
    % body(1).FreeEndPointsStore(:,:,end+1) = body(1).FreeEndPoints; %

    % Shift filament indices
    for ind3 = 1:body(1).nWingSegments+1
        body(1).FreeStartPoints(:,body(1).targetIndices(ind3)+(1:body(1).nFilamentSegments-1)) =...
            FreeUpdate(:,body(1).targetIndices(ind3)+(0:body(1).nFilamentSegments-2));
    end
    
    % Adjust Cross Vorticity Locations
    body(1).CrossStartPoints = body(1).FreeEndPoints(:,1:end-body(1).nFilamentSegments);
    body(1).CrossEndPoints = body(1).FreeEndPoints(:,(body(1).nFilamentSegments+1):end);



end

