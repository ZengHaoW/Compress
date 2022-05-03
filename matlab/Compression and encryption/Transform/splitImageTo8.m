function [imageBlock_8] = splitImageTo8(imageMatrix)
%SPLITIMAGETO8 将图像切割成8 x 8的块
%   此处显示详细说明
    [Height, ~] = size(imageMatrix);
    blockNums = Height / 8;
    dim1Dist = ones(1, blockNums)*8;
    imageBlock_8 = mat2cell(imageMatrix, dim1Dist, dim1Dist);
end

