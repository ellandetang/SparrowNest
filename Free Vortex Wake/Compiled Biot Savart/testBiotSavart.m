% test the batch biot savart program, also graphicaly display the results
clear
% close all
clf
clc

startPoints = [
    0 -.5 0
    0 .5 0
    ]';

endPoints = [
    0 .5 0
    .5 .5 0
    ]';

Gamma = [1,1];
rc = [.1,.1];

x = linspace(-1,1,101);
y = linspace(-1,1,101);

m = length(x)*length(y);

[X,Y] = meshgrid(x,y);

Z = zeros(size(X));

samplePoints = [reshape(X,[1,m]);reshape(Y,[1,m]);reshape(Z,[1,m])];
% samplePoints = [
%     .5 .5 0;
%     .5 -.5 0
%     ]';

tic
V = batchBiotSavart(startPoints,endPoints,Gamma,rc,samplePoints);
toc
tic
V = batchBiotSavart_mex(startPoints,endPoints,Gamma,rc,samplePoints);
toc
contour(X,Y,reshape(V(3,:),[sqrt(m),sqrt(m)]),-10:.1:10)
grid on
