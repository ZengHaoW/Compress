function [LT_E] = HL_JIAMI(LT, x, y, z, h)
    %% 对LT进行高低位加密   H * W为原图像的尺寸, LT尺寸为 H / 16 * W / 16  LT各个元素为8位数, 全程计算为列向量
    [s_H, s_W] = size(LT); %子块的长宽
%     nums = s_H * s_H; %子块的像素个数
    %% 对LT进行高低位加密   H * W为原图像的尺寸, LT尺寸为 H / 16 * W / 16  LT各个元素为8位数, 全程计算为列向量
    LT_H = s_H;
    LT_W = s_W;
    LT_Len = LT_H * LT_W;
    %x序列取LT_H个，y序列取LT_W个，相乘得到置乱序列A

    % x_P = x(LT_H + 1: LT_H * 2);
    % y_P = y(LT_H + 1: LT_H * 2);
    % A = x_P' * y_P;
    % A = reshape(A, 1, []);

    x_P = x(LT_H + 1:LT_H + LT_H * LT_H);
    y_P = y(LT_H + 1:LT_H + LT_H * LT_H);
    x_P = floor(mod((x_P * 10^10), 1024));
    y_P = floor(mod((y_P * 10^10), 1024));

    A = bitxor(x_P, y_P);
    A = reshape(A, 1, []);

    % A = mod(floor(A*power(10,15)), 16);
    A = sort_S(A);
    % A = mod(floor(A*power(10,15)), 1024);
    % S_A = sort(A);
    % [~, A] = ismember(S_A, A);
    %z序列取LT_H个，h序列取LT_W个，相乘得到扩散序列B

    % z_P = z(LT_H + 1: LT_H * 2);
    % h_P = h(LT_H + 1: LT_H * 2);
    % B = z_P' * h_P;
    % B = reshape(B, 1, []);
    % B = mod(floor(B*power(10,16)), 256);

    z_P = z(LT_H + 1:LT_H + LT_H * LT_H);
    h_P = h(LT_H + 1:LT_H + LT_H * LT_H);
    z_P = floor(mod((z_P * 10^10), 256));
    h_P = floor(mod((h_P * 10^10), 256));
    B = bitxor(z_P, h_P);
    B = reshape(B, 1, []);

    D_r = B(1:LT_Len / 2); %用来做行扩散，每行共N个元素
    D_c = B(1 + LT_Len / 2:end); %用来进行列扩散，每列共M个元素

    % fid=fopen("./LT.bin","wb");
    % fwrite(fid,reshape(LT, 1,[]),'uint8');
    % fclose(fid);

    % 将图像分为高4位和低4位，分别用十进制表示
    LT_Bin = de2bi(LT, 8, 'left-msb'); %按列转换，每一行为8位二进制
    LT_Bin_H = LT_Bin(:, 5:8);
    LT_Bin_L = LT_Bin(:, 1:4);
    LT_h = bi2de(LT_Bin_H, 'left-msb');
    % LT_h = reshape(LT_h, LT_H, LT_W);                             %高4位10进制矩阵
    LT_l = bi2de(LT_Bin_L, 'left-msb');
    % LT_l = reshape(LT_l, LT_H, LT_W);                             %低4位10进制矩阵

    % 1. 利用高位图像扰乱低位图像
    LT_l1 = zeros(LT_Len, 1);
    LT_l1(1) = mod(LT_h(1) + LT_l(1), 16); %4位数是16

    for n = 2:LT_Len
        temp = mod(LT_h(n) + LT_l(n), 16);
        LT_l1(n) = bitxor(temp, LT_l1(n - 1)); %最后的低位矩阵
    end

    % 2. 利用序列A置乱高位图像
    LT_h1 = zeros(LT_Len, 1);

    for n = 1:LT_Len
        LT_h1(n) = LT_h(A(n)); %置乱后的高位图像
    end

    % 3. 将LT_l1转换为4比特的二进制，再将相邻两位合并转成一个十进制数得到LT_l2，利用序列B对LT_l2进行扩散操作。
    temp = de2bi(LT_l1, 4, 'left-msb');
    LT_l2 = zeros(LT_Len / 2, 1);

    for i = 1:2:LT_Len
        t = [temp(i, :) temp(i + 1, :)];
        LT_l2((i + 1) / 2) = bi2de(t, 'left-msb');
    end

    % D_r扩散
    LT_l21 = zeros(LT_Len / 2, 1);
    LT_l21(1) = mod(LT_l2(1) + D_r(1), 256);

    for i = 2:LT_Len / 2
        temp = mod(LT_l2(i) + D_r(i), 256);
        LT_l21(i) = bitxor(temp, LT_l21(i - 1));
    end

    % D_c扩散
    LT_l22 = zeros(LT_Len / 2, 1);
    LT_l22(LT_Len / 2) = mod(LT_l21(LT_Len / 2) + D_c(LT_Len / 2), 256);

    for i = LT_Len / 2 - 1:-1:1
        temp = mod(LT_l21(i) + D_c(i), 256);
        LT_l22(i) = bitxor(temp, LT_l22(i + 1));
    end

    % 将8位数恢复成4位数，得到LT_l3
    LT_l3 = zeros(LT_Len, 1);
    temp = de2bi(LT_l22, 8, 'left-msb');

    for i = 1:LT_Len / 2
        LT_l3(i * 2 - 1) = bi2de(temp(i, 1:4), 'left-msb');
        LT_l3(i * 2) = bi2de(temp(i, 5:8), 'left-msb');
    end

    %% 4. 用LT_l3扰乱LT_h1, 异或得到LT_h2
    LT_h2 = bitxor(LT_l3, LT_h1);

    %% 5. 将LT_h2, LT_l3按索引分位奇, 偶序列, 将高位的奇和低位的偶互换。
    [G_H, H_H] = split_GH(LT_h2); %将高位图像分奇偶列
    [G_L, H_L] = split_GH(LT_l3); %将低位图像分奇偶列
    %进行交换
    H_l = G_H;
    G_h = H_L;

    LT_h3 = merge_G_H(G_h, H_H)';
    LT_l4 = merge_G_H(G_L, H_l)';

    %% 6. 将LT_h3, LT_l4合并成8位的LT_E
    temp1 = de2bi(LT_h3, 4, 'left-msb');
    temp2 = de2bi(LT_l4, 4, 'left-msb');
    LT_E = ones(LT_Len, 1);

    for i = 1:LT_Len
        t = [temp1(i, :) temp2(i, :)];
        LT_E(i) = bi2de(t, 'left-msb');
    end
LT_E = reshape(LT_E, LT_H, LT_W);
end
