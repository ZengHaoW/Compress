clear;
clc;
imagePath = './testImage/lena_gray.bmp';
[normalMatrix, suoluetu] = transformTotalImage(imagePath);
oneDimension = reshape(normalMatrix,1,[]);
[H, W] = size(normalMatrix);
x = DC_Code(oneDimension);

c = DC_DeCode(x);
d = reshape(c, H, W);
% length(x)
b = invTransformTotalImage(d,suoluetu);
imshow(b,[])

% 5956123  5863667  5956813