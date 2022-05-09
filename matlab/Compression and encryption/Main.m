clear;clc;
% imagePath = './testImage/peppers.tif';
% sigma = 10;   % noise variance
% InputImg = double(imread(imagePath));
% randn('seed', 0)
% NoiseImg = InputImg + sigma*randn(size(InputImg));   
%  
% figure(1); 
% subplot(121);  imshow(InputImg,[]);  title('Clear Image')
% subplot(122),  imshow(NoiseImg,[]); title('Noise Image')


a = uint8(ones(512, 512) * 255);
imwrite(a, './testImage/white.tiff', 'Compression', 'none');