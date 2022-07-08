clear;clc;
addpath(genpath('./Read Image'));
addpath(genpath('./Chaotic System'));
addpath(genpath('./Transform'));
addpath(genpath('./Encryption'));
addpath(genpath('./Encoding'));
addpath(genpath('./keys'))
% imagePath = './testImage/peppers.tif';
% sigma = 100;   % noise variance
% InputImg = (imread(imagePath));
% InputImg = reshape(InputImg, 1, []);
% randn('seed', 0)
% % NoiseImg = InputImg + sigma*randn(size(InputImg));
% NoiseImg = imnoise(InputImg,'salt & pepper',0.1);
% InputImg = reshape(InputImg, 512, []);
% NoiseImg = reshape(NoiseImg, 512, []);
% figure(1);
% subplot(121);  imshow(InputImg,[]);  title('Clear Image')
% subplot(122),  imshow(NoiseImg,[]); title('Noise Image')

% a = uint8(ones(512, 512) * 255);
% imwrite(a, './testImage/white.tiff', 'Compression', 'none');

% key1 = double(imread('./testImage/lena_suoluetu_E.tiff'));
% key2 = double(imread('./testImage/lena_key2_suoluetu_E.tiff'));
%
% imshow(key1-key2)
%
% imwrite(uint8(key1-key2), './testImage/lena_suoluetu_key(2-1)_E.tiff','Compression','none');
% NPCR UACI
I1 = imread('./suoluetu_E_1P.tiff');
I2 = imread('./suoluetu_E.tiff');
load('image_DNA_1.mat');
load('image_DNA_2.mat');
[npcr, uaci] = NPCR_UACI(image_DNA,image_DNA_1)

% I1 = imread('./testImage/peppers.tiff');
% I2 = I1;
% I2(1,1) = I2(1,1) - 1;
% sha1 = sha256(I1);
% sha1 = sha256(I2);
% 
% imagePath = './testImage/lena.tiff';
% I = readImage(imagePath);
% t_key = [2, 5, 7, 2];
% [e, s] = JIAMI(imagePath, t_key);
