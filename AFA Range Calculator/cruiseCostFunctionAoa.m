function [CruiseEffectiveDrag] = cruiseCostFunctionAoa(CruiseAoA)

% A modification of the cost function for pure angle of attack optimization
% This assumes that the max cruise speed is the most efficient at every
% angle of attack

globalVariableDefinition

MaxCruiseSpeed = fzero(@(V) Lift(V,CruiseAoA) - W,30);

CruiseSpeed = MaxCruiseSpeed;

    CruiseLiftDeficit = W - Lift(CruiseSpeed,CruiseAoA);
    
    % Sanitizes Calculation Results
    if abs(CruiseLiftDeficit)<1e-10
        CruiseLiftDeficit = 0;
    end
    
    CruiseRPM = rotorRPS_fun(CruiseLiftDeficit/N_lift)*60;
    
    if CruiseRPM == 0
        CruisePower = powerCorrection(N_thrust*...
            thrusterPower(Drag(CruiseSpeed,CruiseAoA,CruiseRPM)/N_thrust,CruiseSpeed,CruiseAoA));
    else
        % angle is negative because positive angle brings propeller
        % more aligned with freestream
        CruisePower = powerCorrection(N_lift*lifterPower(CruiseLiftDeficit/N_lift,CruiseSpeed,-CruiseAoA)...
            + N_thrust*thrusterPower(Drag(CruiseSpeed,CruiseAoA,CruiseRPM)/N_thrust,CruiseSpeed,CruiseAoA));
    end
    
    CruiseEffectiveDrag = CruisePower/CruiseSpeed;

end

