function [out] = GammaF(n,A_n,theta)
% Based on the Fourier Series representation of the Circulation
% Gamma(theta) = U_inf*b*SUM_n(B_n sin(n theta))
% Produces Gamma values of the same size of theta based on the indices n
% and the coefficients A_n
% theta can either be up to 2 dimensions
% n and A_n should be of the same size

out = zeros(size(theta));

for ind1 = 1:size(theta,1)
    
    for ind2 = 1:size(theta,2)
        
        out(ind1,ind2) = sum(A_n.*sin(n.*theta(ind1,ind2)));
        
    end
    
end


end