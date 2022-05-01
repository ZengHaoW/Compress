function [restoredImage] = invTransformTotalImage(imageMatrix, thumbnail)
%INVTRANSFORMTOTALIMAGE 逆变换，将imageMatrix_8和缩略图thumbnail还原成原始图像
%   此处显示详细说明
    [H, ~] = size(thumbnail);
    imageMatrixInv = ones(H * 8, H * 8);
    imageMatrixInv_8 = splitImageTo8(imageMatrixInv);
    imageMatrix_8 = splitImageTo8(imageMatrix);
    for i = 1: H
        for j = 1: H
            imageMatrixInv_8{i, j} = transformInv(imageMatrix_8{i, j}, thumbnail(i, j));
        end
    end
    
    restoredImage = cell2mat(imageMatrixInv_8);
end

