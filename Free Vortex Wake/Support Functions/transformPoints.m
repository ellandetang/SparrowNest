function [Xout,Vout] = transformPoints(T,R,V,Om,samplePointsIn)
% Provides the current positions and velocities of the target points in the
% global coordinate frame based off the transformation of the points
% associated coordinate system. The points' original coordinates are given
% relative to their coordinate system.
% T is a 3x1 translation vector
% R is a 3x3 rotation matrix
% V is a 3x1 velocity vector in global coordinates
% Om is a 3x1 angular velocity vector relative to the body coordinate axes
% samplePointsIn is a 3xn matrix of position vectors to transform

% Xout is a 3xn matrix of transformed position vectors the order of
% operations is Rotation followed by translation
% Vout is a 3xn matrix of velocity vectors of the points in the global
% coordinate system in the new position

% keyboard

n = size(samplePointsIn,2);

Xout = R*samplePointsIn + repmat(T,[1,n]);

Vout = R*cross(repmat(Om,[1,n]),samplePointsIn) + repmat(V,[1,n]);

end

