clear;clc;
addpath(genpath('./Read Image'));
addpath(genpath('./Chaotic System'));
addpath(genpath('./Transform'));
addpath(genpath('./Encryption'));
addpath(genpath('./Encoding'));
addpath(genpath('./keys'))

imagePath = './testImage/lena.tiff';

I = imread(imagePath);
keys = sha256(I);
t_key = [2, 5, 7, 2];
[x0, y0, z0, w0] = getkeys(keys, t_key);
[H, W] = size(I);
%混沌序列个数
SUM = H * W;                                               
%根据初值，求解Chen氏超混沌系统，得到四个混沌序列x, y, z, h, 长度均为SUM
[x, y, z, h] = generateSequences(x0, y0, z0, w0, SUM);

image_DNA = DNA_JIAMI(I, x, y, z, h);
save('image_DNA_1', "image_DNA")
image_DNA = DNA_JIEMI(image_DNA_1, x, y, z, h);
