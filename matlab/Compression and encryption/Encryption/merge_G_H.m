function [S] = merge_G_H(X,P)
%将产生的x序列和p序列合并到一起成S序列，
%   x占奇索引，p占偶索引
m = length(X)+length(P);
S = zeros(1,m);%存放step2中生成的序列
for r = 1:m
    if mod(r,2)
       S(r) = X((r+1)/2) ;
    else
        S(r) = P(r/2);
    end
end  
end
