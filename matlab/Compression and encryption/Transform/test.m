clear;clc;

t = [137 135 140 140 138 140 140 140;
143	138	139	143	139	137	140	142;
135	136	138	139	136	138	138	141;
138	137	139	139	138	137	143	137;
137	138	136	135	136	138	141	134;
136	140	137	136	135	132	138	138;
137	139	139	136	131	129	139	138;
138	135	137	134	138	136	139	137]

[a ,~] = transform(t);
a = mod(a,256);
% transformInv(a, b);

% temp = ones(2, 2);
% temp = a(1:2, 3:4);
% a(1:2, 3:4) = a(3:4, 3:4);
% a(3:4, 3:4) = temp;
% temp = a(3:4, 1:2);
% a(3:4, 1:2) = a(3:4, 3:4);
% a(3:4, 3:4) = temp;

% a = positionChange(a);
% a = a + 255;

% x = transformInv2(a, b);
% x == t
% 
% [a ,b] = transform(x);
% a(1,1) = b;
% a = a + 255;

x = transformInv(a);
x = mod(x,256);
x == t

