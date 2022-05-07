clear;clc;
% v0 = [0.3 -0.4 1.2 1];
% fun = @(t,v) chen(t,v);
% [t, v] = ode45(fun, [0:1:1000000], v0);
% 
% x = v(:,1);
% y = v(:,2);
% z = v(:,3);
% w = v(:,4);
% plot(x,y)
% plot(x,z)
% plot(x,w)
tic
[x, y, z ,w] = generateSequences(0.3,-0.4,1.2,1, 256*256);
toc
