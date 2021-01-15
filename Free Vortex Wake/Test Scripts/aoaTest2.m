
clear
close all

alphaList = -190:1:190;

for ind1 = 1:length(alphaList)
alpha = alphaList(ind1);
V = [-1,0,0]';
X = [cosd(alpha) 0 -sind(alpha)]';
Y = [-sind(alpha) 0 -cosd(alpha)]';

alphaOut(ind1) = rad2deg(atan2(dot(Y,V,1),dot(-X,V,1)));
end

plot(alphaList,alphaOut)
grid on