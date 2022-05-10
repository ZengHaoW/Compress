function [imageMatrix] = readImage(imagePath)
%READ 读取灰度图像或者RGB彩色图像，返回对应像素值矩阵
%   读取图片  (h, w, )
    imageMatrix = imread(imagePath);
    imageMatrix = double(imageMatrix);

    %%临时
%     imageMatrix(3,3) = bitxor(255, imageMatrix(3,3));
end

