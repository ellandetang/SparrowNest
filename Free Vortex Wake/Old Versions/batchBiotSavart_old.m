function [V] = batchBiotSavart(startPoints,endPoints,Gamma,rc,samplePoints)
% startPoints 3xn matrix of start coordinates for filaments
% endPoints 3xn matrix of start coordinates for filaments, must be same
% size as startPoints
% Gamma 1xn array of vortex strengths
% rc 1xn array of core sizes
% samplePoints 3xm matrix of coordinates to sample


n = size(startPoints,2);
m = size(samplePoints,2);

% Filament vector
l = endPoints - startPoints;
lmag = sqrt(sum(l.^2,1));

% Split sample vector into components row is sample, column is filament

ra = startPoints;
rb = endPoints;

V = zeros(3,m);

for ind1 = 1:m
    
    rp = repmat(samplePoints(:,ind1),[1,n]);
    
    r1 = rp - ra;
    r2 = rp - rb;
    
    r1mag = sqrt(sum(r1.^2,1));
    r2mag = sqrt(sum(r2.^2,1));
    
    c1 = dot(l,r1,1)./(lmag.*r1mag);
    c2 = dot(l,r2,1)./(lmag.*r2mag);
    
    h = sqrt(r1mag.^2.*(ones(1,n) - c1.^2));
    
    e = cross(l,r1,1);
    emag = sqrt(sum(e.^2,1));
    
    V(:,ind1) = (e./repmat(emag,[3,1]))*(Gamma./(4*pi).*(h./(rc.^2 + h.^2)).*(c1 - c2))';
    
end



end

