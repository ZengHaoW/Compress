function [afterTransform] = getFourInv(LT, RT, LB, RB)
%GETFOURINV 此处显示有关此函数的摘要
%   此处显示详细说明
    addpath(genpath('../Transform'));

    [H, W] = size(LT);
    suoluetu = ones(H * 2, W * 2);

    suoluetu(1: H, 1: W) = LT;
    suoluetu(H + 1: H * 2, 1: W) = RT;
    suoluetu(1: H, H + 1: W * 2) = LB;
    suoluetu(H + 1: H * 2, W + 1: W * 2) = RB;

    thumbnail_8 = splitImageTo8(suoluetu);
    blockNums = H * 2 / 8;

    for i = 1: blockNums
        for j = 1: blockNums
            [thumbnail_8{i, j}, p] = transform(thumbnail_8{i, j});
            thumbnail_8{i, j}(1, 1) = p;
            % 将矩阵位置交换并进行逆变换
            temp = thumbnail_8{i, j};
%             temp = positionChange(temp);
            temp = temp - 255;
            thumbnail_8{i, j} = transformInv2(temp, temp(1, 1));
        end
    end

    afterTransform = cell2mat(thumbnail_8);
end

