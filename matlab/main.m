clear;
clc;
imagePath = './testImage/lena_gray.bmp';
[a,c] = transformTotalImage(imagePath);
b = invTransformTotalImage(a,c);
imshow(b,[])
