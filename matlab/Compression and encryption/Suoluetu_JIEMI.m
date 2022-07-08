function [suoluetu] = Suoluetu_JIEMI(suoluetu_E, x, y, z, h)
    %SUOLUETU_JIEMI 此处显示有关此函数的摘要
    %   此处显示详细说明
    [H, W] = size(suoluetu_E);
    LT_H = H / 2;
    [LT_E, RT_E, LB_E, RB_E] = getFour(suoluetu_E);

    DNA_Image_E = [RT_E, LB_E, RB_E];
    DNA_Image = DNA_JIEMI(DNA_Image_E, x, y, z, h);
    RT = DNA_Image(1:end, 1: LT_H);
    LB = DNA_Image(1:end, LT_H + 1: LT_H * 2);
    RB = DNA_Image(1:end, LT_H * 2 + 1: end);

    LT = HL_JIEMI(LT_E, x, y, z, h);


    suoluetu = getFourInv(LT, RT, LB, RB);
end
