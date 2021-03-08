clear
close all


rotX = @(th) [1 0 0;
    0 cos(th), -sin(th);
    0 sin(th), cos(th)];

rotY = @(th) [cos(th),0, sin(th);
    0,1,0;
    -sin(th),0, cos(th)];

rotZ = @(th) [cos(th), -sin(th),0;
    sin(th), cos(th),0;
    0,0,1];


n = 11;
X = linspace(0,1,n);
Y = zeros(1,n);
Z = zeros(1,n);

samplePoints = [X;Y;Z];

T = [.5,0,0]';
R = rotZ(pi/2);

V = [0 0 0]';
Om = [0 0 1]';


[Xout,Vout] = transformPoints(T,R,V,Om,samplePoints);

line(samplePoints(1,:),samplePoints(2,:),samplePoints(3,:),'color',[0 0 1])

line(Xout(1,:),Xout(2,:),Xout(3,:),'color',[1 0 0])

xlabel('x')
ylabel('y')
zlabel('z')
view(45,45)
grid on
