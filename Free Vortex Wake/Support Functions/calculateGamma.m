function [body] = calculateGamma(body,simulation)
% take struct variable representing the body and the freestream velocity
% and calculate the Circulation along the wing
    sectionVelocity = repmat(simulation.U,[1,size(body(1).VInducedFixed,2)]) + body(1).VInducedFixed;
    FixedAlpha = atan2(dot(body(1).sectionY,sectionVelocity,1),dot(-body(1).sectionX,sectionVelocity,1));
    FixedCL = CLNACA0012(FixedAlpha);
    body(1).FixedGamma_Old = body(1).FixedGamma;
    body(1).FixedGamma = 1/2*simulation.Umag*FixedCL.*body(1).chord;
    
end

