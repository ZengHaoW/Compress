function [suoluetu] = getFourInv(LT, RT, LB, RB)
    %GETFOURINV 此处显示有关此函数的摘要
    %   此处显示详细说明
    addpath(genpath('../Transform'));

    [LT_H, LT_W] = size(LT);
    H = LT_H * 2;
    W = LT_W * 2;

    blockNums = H / 8;
    LT_Temp = ones(4, 4);
    RT_Temp = ones(4, 4);
    LB_Temp = ones(4, 4);
    RB_Temp = ones(4, 4);
    temp = ones(8, 8);

    RB = bitxor(RB, LT);
    LB = bitxor(LB, LT);
    RT = bitxor(RT, LT);
    LT = bitxor(bitxor(bitxor(LT, RB), LB), RT);

    suoluetu = ones(H, W);
    suoluetu_8 = splitImageTo8(suoluetu);

    for i = 1:blockNums

        for j = 1:blockNums

            LT_Temp = LT((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4);
            RT_Temp = RT((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4);
            LB_Temp = LB((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4);
            RB_Temp = RB((i - 1) * 4 + 1:i * 4, (j - 1) * 4 + 1:j * 4);

            temp(1:4, 1:4) = LT_Temp;
            temp(1:4, 5:8) = RT_Temp;
            temp(5:8, 1:4) = LB_Temp;
            temp(5:8, 5:8) = RB_Temp;

            suoluetu_8{i, j} = transformInv(temp);

        end

    end

    suoluetu = cell2mat(suoluetu_8);
    suoluetu = mod(suoluetu, 256);
end
