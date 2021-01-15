function [out] = bandReject(in,width,slope)

out = (tanh(slope*(-in-width/2))+1)/2 + (tanh(slope*(in-width/2))+1)/2;

end

