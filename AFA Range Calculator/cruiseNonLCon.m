function [c,cEq] = cruiseNonLCon(CruiseAoA,CruiseSpeed)

globalVariableDefinition

MaxCruiseSpeed = fzero(@(V) Lift(V,CruiseAoA) - W,30);

c = CruiseSpeed - MaxCruiseSpeed;

cEq = [];

end

