clear;clc;
addpath(genpath('./Read Image'));
addpath(genpath('./Chaotic System'));
addpath(genpath('./Transform'));
addpath(genpath('./Encryption'));
addpath(genpath('./Encoding'));
addpath(genpath('./keys'))
%% 载入加密数据和密钥
load("total_E");
load("sha256_keys");
load("t_keys");
load("suoluetu_E");
%%

[x0, y0, z0, w0] = getkeys(keys, t_key);

%% 生成四维混沌序列x,y,z,h
H = 512;
W = 512;
%混沌序列个数
SUM = H * W;
%根据初值，求解Chen氏超混沌系统，得到四个混沌序列x, y, z, h, 长度均为SUM
[x, y, z, h] = generateSequences(x0, y0, z0, w0, SUM);

%% 缩略图解密
% suoluetu_E = double(imnoise(uint8(suoluetu_E),'salt & pepper',0.1));
suoluetu_E(1:16, 1:16) = 0;
suoluetu = Suoluetu_JIEMI(suoluetu_E, x, y, z, h);
% suoluetu = Suoluetu_JIEMI(suoluetu,x,y,z,h);
imshow(suoluetu, [])
%% 解密DC_Code
DC_Code = Diffusion(DC_Encrytion, x);
d = DC_DeCode(DC_Code);
d = reshape(d, H, W);
original_image = invTransformTotalImage(d);
figure, imshow(original_image, [])
