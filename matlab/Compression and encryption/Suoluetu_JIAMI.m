function [suoluetu_E] = Suoluetu_JIAMI(suoluetu, x, y, z, h)
    %SUOLUETU_JIAMI 此处显示有关此函数的摘要
    %   此处显示详细说明
    [LT, RT, LB, RB] = getFour(suoluetu);
    [H, W] = size(suoluetu);
    [LT_H, ~] = size(LT);
    %     aaa = [LT, LB; RT, RB];
    %% DNA加密RT，LB，RB三个子带
    DNA_Image = [RT, LB, RB];
    % imshow(DNA_Image, [])
    DNA_JIAMI_Image = DNA_JIAMI(DNA_Image, x, y, z, h);
    RT_E = DNA_JIAMI_Image(1:end, 1:LT_H);
    LB_E = DNA_JIAMI_Image(1:end, LT_H + 1:LT_H * 2);
    RB_E = DNA_JIAMI_Image(1:end, LT_H * 2 + 1:end);
    % imshow(DNA_JIAMI_Image)
    % isequal(DNA_JIEMI(DNA_JIAMI_Image, x, y, z, h), DNA_Image)

    %% HL加密LT子带
    LT_E = HL_JIAMI(LT, x, y, z, h);
    %     sss = HL_JIEMI(LT_E, x, y, z, h);
    %     isequal(sss,LT)
    %     [LT_H, LT_W] = size(LT_E);
    suoluetu_E = getFourInv(LT_E, RT_E, LB_E, RB_E);
    %     imshow(suoluetu_E, [])
end
