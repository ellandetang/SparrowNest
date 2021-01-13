clear
% close all
clf

aoaList = linspace(-pi,pi,1001);

highPass = @(in,slope) (tanh(slope*(in))+1)/2;
bandReject = @(in,width,slope) (tanh(slope*(-in-width/2))+1)/2 + (tanh(slope*(in-width/2))+1)/2;
bandPass = @(in,width,slope) -(tanh(slope*(in-width/2))+1)/2 + (tanh(slope*(in+width/2))+1)/2;
transitionWidth = 14;
linearWidth = 29;
CL = @(aoa) bandPass(aoa,deg2rad(linearWidth),8/deg2rad(transitionWidth)).*(aoa*2*pi) + ...
    bandReject(aoa,deg2rad(linearWidth),8/deg2rad(transitionWidth)).*1.15.*sin(2*aoa);
% CL = bandPass(aoaList,deg2rad(linearWidth),8/deg2rad(transitionWidth)).*(aoaList*2*pi) + ...
%     bandReject(aoaList,deg2rad(linearWidth),8/deg2rad(transitionWidth)).*1.15.*sin(2*aoaList);

plot(rad2deg(aoaList),CL(aoaList))
grid on