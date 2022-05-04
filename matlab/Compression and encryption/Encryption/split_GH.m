function [G,H] = split_GH(P)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
L = length(P);
if mod(L,2) 
    G = zeros(1,(L+1)/2);%奇列
    H = zeros(1,(L-1)/2);%偶列
else
    G = zeros(1,L/2);%奇列
    H = zeros(1,L/2);%偶列
end  
%将灰度图片分为奇偶列
x = 1;%计数用
y = 1;
for n = 1:L
    if mod(n,2)
        G(x)=P(n);
        x = x + 1;
    else
        H(y)=P(n);
        y = y + 1;
    end  
end
end

