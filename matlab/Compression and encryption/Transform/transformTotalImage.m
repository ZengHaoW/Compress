function [normalMatrix,thumbnail] = transformTotalImage(imageMatrix)
%TRANSFORMTOTALIMAGE 对整张图像进行变换
%   得到计算后结果imageMatrix_8, 访问缩略图thumbnail,normalMatrix为imageMatrix_8合并
%   imageMatrix_8（抛去缩略图，需要{i, j}访问, 每个imageMatrix_8{i， j}为8*8的矩阵。
%     imageMatrix = readImage(imagePath);
%     imageMatrix(1,1) = imageMatrix(1,1) - 1;
    imageMatrix_8 = splitImageTo8(imageMatrix);
    [H, ~] = size(imageMatrix);
    thumbnailSzie = H / 8;
    thumbnail = ones(thumbnailSzie, thumbnailSzie); 
    for i = 1: thumbnailSzie
        for j = 1: thumbnailSzie
            [imageMatrix_8{i, j}, thumbnail(i, j)] = transform(imageMatrix_8{i, j});
        end
    end
%     normalMatrix = imageMatrix_8;
    normalMatrix = cell2mat(imageMatrix_8);
end
