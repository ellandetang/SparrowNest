function [body] = calculateGamma(body,simulation,indB)
% take struct variable representing the body and the freestream velocity
% and calculate the Circulation along the wing

    sectionVelocity = repmat(simulation.U,[1,size(body(indB).VInducedFixed,2)]) + body(indB).VInducedFixed - body(indB).FixedSamplePoints_V;
    sectionVelocityMag = sqrt(sum(sectionVelocity.^2,1));
    FixedAlpha = atan2(dot(body(indB).sectionY,sectionVelocity,1),dot(-body(indB).sectionX,sectionVelocity,1));
    FixedCL = CLNACA0012(FixedAlpha);
    body(indB).FixedGamma_Old = body(indB).FixedGamma;
    body(indB).FixedGamma = 1/2.*sectionVelocityMag.*FixedCL.*body(indB).chord;
    
    if any(isnan(body(indB).FixedGamma))
        keyboard        
    end
    
end

