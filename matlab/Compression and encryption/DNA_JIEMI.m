function [encryptedImage] = DNA_JIEMI(image, x, y, z, h)
    %DNA_ENCODING 利用混沌序列对图像进行DNA加密
    %   此处显示详细说明
    addpath(genpath('./Read Image'));
    addpath(genpath('./Chaotic System'));
    addpath(genpath('./Transform'));
    addpath(genpath('./Encryption'));
    addpath(genpath('./Encoding'));
    addpath(genpath('./keys'))

    %     [~, image] = transformTotalImage(image);
    %     image(1,2) = 0;
    [H, W] = size(image);
    Q_B = ones(H, W);
    nums = H * W;
    R = x(1:H)' * y(1:W); %随机矩阵
    R = mod(round(R * 10^4), 256); %化为0-255的整数

    x = mod(round(x * 10^4), 8) + 1; %使混沌序列X变成范围为1~8的整数
    y = mod(round(y * 10^4), 8) + 1; %使混沌序列Y变成范围为1~8的整数
    z = mod(round(z * 10^4), 4); %使混沌序列Z变成范围为1~4的整数
    h = mod(round(h * 10^4), 8) + 1; %使混沌序列H变成范围为1~8的整数

    t = 1;

    e = nums / t / t;

    for i = e:-1:2
        R_1 = DNABIAN(fenkuai(t, R, i), x(i));

        Q_1 = DNABIAN(fenkuai(t, image, i), h(i));
        Q_last = DNABIAN(fenkuai(t, image, i - 1), h(i - 1));

        Q_2 = DNAYUNSUAN(Q_1, Q_last, z(i));
        Q_3 = DNAYUNSUAN(Q_2, R_1, z(i));

        xx = floor(i / e) + 1;
        yy = mod(i, e);

        if yy == 0
            xx = xx - 1;
            yy = e;
        end

        %Q_B((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t) = DNAJIE(Q_3, h(i));
        Q_B = fuzhi(t, Q_B, i, DNAJIE(Q_3, x(i)));
    end

    R_1 = DNABIAN(fenkuai(t, R, 1), x(1));
    Q_1 = DNABIAN(fenkuai(t, image, 1), h(1));
    Q_last = DNAYUNSUAN(Q_1, R_1, z(1));
    Q_B(1:t, 1:t) = DNAJIE(Q_last, x(1));
    encryptedImage = Q_B;

end

function [result] = DNAJIE(dnaMatirx, dnavalue)
    [H, W] = size(dnaMatirx);
    result = ones(H, W / 4);

    for i = 1:H
        result(i, 1) = DNADecoding(dnaMatirx(i, 1:4), dnavalue);
        %         result(i, 2) = DNADecoding(dnaMatirx(i, 5:8), dnavalue);
    end

end

function [result] = DNAYUNSUAN(dnaMatirx1, dnaMatirx2, dnavalue)
    [H, W] = size(dnaMatirx1);
    result = ones(H, W);

    for i = 1:H

        for j = 1:W
            result(i, j) = DNA_diffusion(dnaMatirx1(i, j), dnaMatirx2(i, j), dnavalue);
        end

    end

end

function [result] = DNABIAN(matrix4, dnavalue)
    [H, W] = size(matrix4);
    result = ones(H, W * 4);

    for i = 1:H

        for j = 1:W
            result(i, (j - 1) * 4 + 1:j * 4) = DNAEncoding(matrix4(i, j), dnavalue);
        end

    end

end

function [fv] = fenkuai(t, I, num)
    [~, N] = size(I);
    N = N / t;
    x = floor(num / N) + 1; %第几大行
    y = mod(num, N); %第几大列

    if y == 0
        x = x - 1;
        y = N;
    end

    fv = I(t * (x - 1) + 1:t * x, t * (y - 1) + 1:t * y);
end

function [I] = fuzhi(t, I, num, value)
    [~, N] = size(I);
    N = N / t;
    x = floor(num / N) + 1; %第几大行
    y = mod(num, N); %第几大列

    if y == 0
        x = x - 1;
        y = N;
    end

    I(t * (x - 1) + 1:t * x, t * (y - 1) + 1:t * y) = value;
end
