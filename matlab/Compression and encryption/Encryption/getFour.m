function [LT, RT, LB, RB] = getFour(suoluetu)
    %THUMBNAILENCRYPTION 对缩略图进行加密处理
    % 完成变换
    addpath(genpath('../Chaotic System'));
    addpath(genpath('../Transform'));

    [H, W] = size(suoluetu);
    LT_H = H / 2;
    suoluetu_8 = splitImageTo8(suoluetu);
    blockNums = H / 8;
    LT_Temp = ones(4, 4);
    RT_Temp = ones(4, 4);
    LB_Temp = ones(4, 4);
    RB_Temp = ones(4, 4);
    LT = ones(H / 2, W / 2);
    RT = ones(H / 2, W / 2);
    LB = ones(H / 2, W / 2);
    RB = ones(H / 2, W / 2);
    temp = ones(8, 8);
    for i = 1:blockNums

        for j = 1:blockNums
            [suoluetu_8{i, j}, ~] = transform(suoluetu_8{i, j});
            temp = suoluetu_8{i, j};
            temp = mod(temp, 256);
            LT_Temp = temp(1:4, 1:4);
            RT_Temp = temp(1:4, 5:8);
            LB_Temp = temp(5:8, 1:4);
            RB_Temp = temp(5:8, 5:8);

            LT((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4) = LT_Temp;
            RT((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4) = RT_Temp;
            LB((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4) = LB_Temp;
            RB((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4) = RB_Temp;
        end

    end

    LT = bitxor(bitxor(bitxor(LT, RT), LB), RB);
    RT = bitxor(RT, LT);
    LB = bitxor(LB, LT);
    RB = bitxor(RB, LT);
    % thumbnail_8 = splitImageTo8(thumbnail);
    % [H, W] = size(thumbnail);
    % blockNums = H / 8;
    % LT = ones(H / 2, W / 2);
    % RT = ones(H / 2, W / 2);
    % LB = ones(H / 2, W / 2);
    % RB = ones(H / 2, W / 2);

    % for i = 1:blockNums

    %     for j = 1:blockNums
    %         [thumbnail_8{i, j}, p] = transform(thumbnail_8{i, j});
    %         temp = thumbnail_8{i, j};
    %         %             temp = positionChange(temp);
    %         temp = temp + 255;
    %         LT_Temp = temp(1:4, 1:4);
    %         RT_Temp = temp(1:4, 5:8);
    %         LB_Temp = temp(5:8, 1:4);
    %         RB_Temp = temp(5:8, 5:8);

    %         LT((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4) = LT_Temp;
    %         RT((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4) = RT_Temp;
    %         LB((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4) = LB_Temp;
    %         RB((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4) = RB_Temp;

    %         %             thumbnail_8{i, j} = transformInv2(temp);
    %     end

    % end
    % % LT = bitxor(bitxor(bitxor(LT,RT), LB), RB);
    % % RT = bitxor(bitxor(RT, LB), RB);
    % % LB = bitxor(LB, RB);
    % % RB = bitxor(RB, LT);

    % new_suoluetu = [LT, RT; LB, RB];
    % new_suoluetu_8 = splitImageTo8(new_suoluetu);

    % for i = 1:blockNums

    %     for j = 1:blockNums
    %         new_suoluetu_8{i, j} = transformInv2(new_suoluetu_8{i, j});
    %     end

    % end

    % afterTransform = cell2mat(new_suoluetu_8);
    % % 将图片分成4块，分别位LT, RT, LB, RB
    % smallBlockLength = H / 2;
    % LT = afterTransform(1:smallBlockLength, 1:smallBlockLength);
    % LB = afterTransform(smallBlockLength + 1:smallBlockLength * 2, 1:smallBlockLength);
    % RT = afterTransform(1:smallBlockLength, smallBlockLength + 1:smallBlockLength * 2);
    % RB = afterTransform(smallBlockLength + 1:smallBlockLength * 2, smallBlockLength + 1:smallBlockLength * 2);

end
