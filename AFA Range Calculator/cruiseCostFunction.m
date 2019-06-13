function [CruiseEffectiveDrag] = cruiseCostFunction(CruiseAoA,CruiseSpeed)

globalVariableDefinition

MaxCruiseSpeed = fzero(@(V) Lift(V,CruiseAoA) - W,30);

% CruiseSpeed = MaxCruiseSpeed;
if CruiseSpeed > MaxCruiseSpeed
    multiplier = 1 + (CruiseSpeed - MaxCruiseSpeed);
    CruiseSpeed = MaxCruiseSpeed;
else
     multiplier = 1;
end
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
    
    CruiseEffectiveDrag = multiplier*CruisePower/CruiseSpeed;

end

