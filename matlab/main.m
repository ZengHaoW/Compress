clear;
clc;
imagePath = './testImage/7.2.01.tiff';
[normalMatrix, a,c] = transformTotalImage(imagePath);
oneDimension = reshape(normalMatrix,1,[]);
x = DC_Code(oneDimension);
size(x)
% b = invTransformTotalImage(a,c);
% imshow(b,[])

% 5956813  5863667