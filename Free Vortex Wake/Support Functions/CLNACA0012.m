function [CL] = CLNACA0012(alpha)

transitionWidth = 14;
linearWidth = 29;
CL = bandPass(alpha,deg2rad(linearWidth),8/deg2rad(transitionWidth)).*(alpha*2*pi) + ...
    bandReject(alpha,deg2rad(linearWidth),8/deg2rad(transitionWidth)).*1.15.*sin(2*alpha);

end

