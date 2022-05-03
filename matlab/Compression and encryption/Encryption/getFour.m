
function [LT, RT, LB, RB] = getFour(thumbnail)
%THUMBNAILENCRYPTION 对缩略图进行加密处理
    % 完成变换
    addpath(genpath('../Chaotic System'));
    addpath(genpath('../Transform'));

    thumbnail_8 = splitImageTo8(thumbnail);
    [H, ~] = size(thumbnail);
    blockNums = H / 8;
    for i = 1: blockNums
        for j = 1: blockNums
            [thumbnail_8{i, j}, p] = transform(thumbnail_8{i, j});
            thumbnail_8{i, j}(1, 1) = p;
        end
    end
    afterTransform = cell2mat(thumbnail_8);
    % 将变换后的值每个加上255
    afterTransform = afterTransform + 255;
    % 将图片分成4块，分别位LT, RT, LB, RB
    smallBlockLength = H / 2;
    LT = afterTransform(1: smallBlockLength, 1: smallBlockLength);
    RT = afterTransform(smallBlockLength + 1: smallBlockLength * 2, 1: smallBlockLength);
    LB = afterTransform(1: smallBlockLength, smallBlockLength + 1: smallBlockLength * 2);
    RB = afterTransform(smallBlockLength + 1: smallBlockLength * 2, smallBlockLength + 1: smallBlockLength * 2);
    %% RT LB RB用DNA加密
    
    %% LT用高低位加密
    
end

