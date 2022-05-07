function [x, y, z, w] = getkeys(imgPath, t)
%GETKEYS 此处显示有关此函数的摘要
%   此处显示详细说明
    I = imread(imgPath);

    keys = sha256(I);
    k = ones(1, 32);
    for i = 1: 32
        temp = keys(i * 2 - 1: i * 2);
        k(i) = hex2dec(temp);
    end
    
    h = ones(1, 4);
    h(1) = k(1);
    h(2) = k(9);
    h(3) = k(17);
    h(4) = k(25);
    for i = 2: 8
        h(1) = bitxor(h(1), k(i-1));
        h(2) = bitxor(h(2), k(i + 8 - 1));
        h(3) = bitxor(h(3), k(i + 16 -1));
        h(4) = bitxor(h(4), k(i + 24 - 1));
    end
    for i = 1: 4
        temp = dec2bin(h(i));
        temp = circshift(temp, t(i));
        temp = bin2dec(temp);
        h(i) = temp / 255;
    end
    x = mod((h(1) + h(2)) * 10^10, 256) / 255;
    y = mod((h(3) + h(2)) * 10^10, 256) / 255;
    z = mod((h(3) + h(4)) * 10^10, 256) / 255;
    w = mod((h(1) + h(2) + h(3) + h(4)) * 10^10, 256) / 255;
end

