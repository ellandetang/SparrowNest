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

% Split sample vector into components row is filament, column is sample,
% depth is components


l12(:,:,1) = repmat(l(1,:)',[1,m]);
l12(:,:,2) = repmat(l(2,:)',[1,m]);
l12(:,:,3) = repmat(l(3,:)',[1,m]);

l12mag = repmat(lmag',[1,m]);

ra = startPoints;
rb = endPoints;
rp = samplePoints;

r1(:,:,1) = repmat(rp(1,:),[n,1]) - repmat(ra(1,:)',[1,m]);
r1(:,:,2) = repmat(rp(2,:),[n,1]) - repmat(ra(2,:)',[1,m]);
r1(:,:,3) = repmat(rp(3,:),[n,1]) - repmat(ra(3,:)',[1,m]);

r1mag = sqrt(sum(r1.^2,3));

r2(:,:,1) = repmat(rp(1,:),[n,1]) - repmat(rb(1,:)',[1,m]);
r2(:,:,2) = repmat(rp(2,:),[n,1]) - repmat(rb(2,:)',[1,m]);
r2(:,:,3) = repmat(rp(3,:),[n,1]) - repmat(rb(3,:)',[1,m]);

r2mag = sqrt(sum(r2.^2,3));

% c1 = dot(l12./repmat(l12mag,[1,1,3]),r1./repmat(r1mag,[1,1,3]),3);
% c2 = dot(l12./repmat(l12mag,[1,1,3]),r2./repmat(r2mag,[1,1,3]),3);
c1 = dot(l12,r1,3)./(l12mag.*r1mag);
c2 = dot(l12,r2,3)./(l12mag.*r2mag);
c1(c1 > 1) = 1;
c1(c1 < -1) = -1;
c2(c2 > 1) = 1;
c2(c2 < -1) = -1;

h = sqrt(r1mag.^2.*(ones(n,m) - c1.^2));

e = cross(l12,r1,3);
emag = sqrt(sum(e.^2,3));


AvMatrix = repmat(Gamma',[1,m])./(4*pi).*(h./(repmat(rc',[1,m]).^2 + h.^2)).*(c1 - c2)./emag;

% Sanitize for samplepoints close to filaments
AvMatrix(h == 0 | r1mag == 0 | r2mag == 0) = 0;

V_temp = sum(e.*repmat(AvMatrix,[1,1,3]),1);

V = [V_temp(:,:,1);V_temp(:,:,2);V_temp(1,:,3)];

if any(imag(V))
    keyboard
end

end

