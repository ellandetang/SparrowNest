function [out] = epsilonF(n,A_n,theta)
% Produces Gamma values of the same size of theta based on the indices n
% and the coefficients A_n
% theta can either be up to 2 dimensions
% n and A_n should be of the same size

out = zeros(size(theta));

for ind1 = 1:size(theta,1)
    
    for ind2 = 1:size(theta,2)
        if theta(ind1,ind2) == pi
            out(ind1,ind2) = 1/2*sum(n.*A_n.*n.*(-1).^(n+1));
        elseif theta(ind1,ind2) == 0
            out(ind1,ind2) = 1/2*sum(n.*A_n.*n);
        else
            out(ind1,ind2) = 1/2*sum(n.*A_n.*sin(n.*theta(ind1,ind2))./sin(theta(ind1,ind2)));
        end
    end
    
end


end

