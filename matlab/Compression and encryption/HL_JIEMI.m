function [LT] = HL_JIEMI(LT_E, x, y, z, h)
    %HL_JIEMI 此处显示有关此函数的摘要
    %% 解密LT_E
    [LT_H, LT_W] = size(LT_E);
    LT_Len = LT_H * LT_W;
    x_P = x(LT_H + 1:LT_H + LT_H * LT_H);
    y_P = y(LT_H + 1:LT_H + LT_H * LT_H);
    x_P = floor(mod((x_P * 10^10), 1024));
    y_P = floor(mod((y_P * 10^10), 1024));
    % 置乱序列A
    A = bitxor(x_P, y_P);
    A = reshape(A, 1, []);
    A = sort_S(A);

    z_P = z(LT_H + 1:LT_H + LT_H * LT_H);
    h_P = h(LT_H + 1:LT_H + LT_H * LT_H);
    z_P = floor(mod((z_P * 10^10), 256));
    h_P = floor(mod((h_P * 10^10), 256));
    B = bitxor(z_P, h_P);
    B = reshape(B, 1, []);

    D_r = B(1:LT_Len / 2); %用来做行扩散，每行共N个元素
    D_c = B(1 + LT_Len / 2:end); %用来进行列扩散，每列共M个元素

    %% 1. 将LT_E分割成LT_h3, LT_l4
    % 将图像分为高4位和低4位，分别用十进制表示
    LT_Bin = de2bi(LT_E, 8, 'left-msb'); %按列转换，每一行为8位二进制
    LT_Bin_H = LT_Bin(:, 1:4);
    LT_Bin_L = LT_Bin(:, 5:8);

    LT_h3 = bi2de(LT_Bin_H, 'left-msb');
    LT_l4 = bi2de(LT_Bin_L, 'left-msb');

    %% 2. 将LT_h3, LT_l4按索引分位奇, 偶序列, 将高位的奇和低位的偶互换得到将LT_h2，将LT_l3
    [G_H, H_H] = split_GH(LT_h3); %将高位图像分奇偶列
    [G_L, H_L] = split_GH(LT_l4); %将低位图像分奇偶列
    %进行交换
    H_l = G_H;
    G_h = H_L;

    LT_h2 = merge_G_H(G_h, H_H)';
    LT_l3 = merge_G_H(G_L, H_l)';

    %% 3. 用LT_l3扰乱LT_h2, 异或得到LT_h1
    LT_h1 = bitxor(LT_l3, LT_h2);
    %% 4. 将LT_l3转换为4比特的二进制，再将相邻两位合并转成一个十进制数得到LT_l2，利用序列B对LT_l2进行扩散操作得到LT_l1.
    temp = de2bi(LT_l3, 4, 'left-msb');
    LT_l2 = zeros(LT_Len / 2, 1);

    for i = 1:2:LT_Len
        t = [temp(i, :) temp(i + 1, :)];
        LT_l2((i + 1) / 2) = bi2de(t, 'left-msb');
    end

    % D_c扩散
    LT_l22 = zeros(LT_Len / 2, 1);

    for i = 1:LT_Len / 2 - 1
        temp = bitxor(LT_l2(i), LT_l2(i + 1));
        LT_l22(i) = mod(temp - D_c(i), 256);
    end

    LT_l22(LT_Len / 2) = mod(LT_l2(LT_Len / 2) - D_c(LT_Len / 2), 256);

    % D_r扩散
    LT_l21 = zeros(LT_Len / 2, 1);

    for i = LT_Len / 2:-1:2
        temp = bitxor(LT_l22(i), LT_l22(i - 1));
        LT_l21(i) = mod(temp - D_r(i), 256);
    end

    LT_l21(1) = mod(LT_l22(1) - D_r(1), 256);

    % 将8位数恢复成4位数，得到LT_l1
    LT_l1 = zeros(LT_Len, 1);
    temp = de2bi(LT_l21, 8, 'left-msb');

    for i = 1:LT_Len / 2
        LT_l1(i * 2 - 1) = bi2de(temp(i, 1:4), 'left-msb');
        LT_l1(i * 2) = bi2de(temp(i, 5:8), 'left-msb');
    end

    % fid = fopen('./LT_l1.bin');
    % qwe = fread(fid)';
    % fclose(fid);
    % isequal(qwe, LT_l1')
    %% 5. 利用序列A置乱高位图像LT_h1得到LT_h
    LT_h = zeros(LT_Len, 1);

    for n = 1:LT_Len
        LT_h(A(n)) = LT_h1(n); %置乱后的高位图像
    end

    %% 6. 利用高位图像扰乱低位图像LT_l1得到LT_l
    LT_l = zeros(LT_Len, 1);

    for i = LT_Len:-1:2
        temp = bitxor(LT_l1(i), LT_l1(i - 1));

        LT_l(i) = mod(temp - LT_h(i), 16);
    end

    LT_l(1) = mod(LT_l1(1) - LT_h(1), 16);

    %% 7. 将高低位LT_h,LT_l合并得到LT
    temp2 = de2bi(LT_h, 4, 'left-msb');
    temp1 = de2bi(LT_l, 4, 'left-msb');
    LT = ones(LT_Len, 1);

    for i = 1:LT_Len
        t = [temp1(i, :) temp2(i, :)];
        LT(i) = bi2de(t, 'left-msb');
    end
    LT = reshape(LT, LT_H, LT_W);
end
