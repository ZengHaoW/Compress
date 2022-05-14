clear;clc;
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

a = uint8(ones(3000, 4000) * 255);
imwrite(a, './white.jpg')


