function [ h ] = Entropy(x)
% Calculating the Entropy Image 
%     [~,N] = size(x);
%     x = double(x);
%     xh = hist( x(:), N);
%     xh = xh / sum(xh(:));
%     i = find(xh);
%     h = - sum(xh(i).*log2(xh(i)));
    x = uint8(x);
    h = entropy(x);
end
