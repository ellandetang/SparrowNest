function [out] = Heaviside(xi)

xi = xi/.04;

out(xi < -1) = 0;
out(xi > 1) = 1;
selectionIndices = ((xi >= -1 & xi <= 1));
out(selectionIndices) = 1/2*(1 + xi(selectionIndices) + 1/pi*sin(pi*xi(selectionIndices)));


end

