clear;clc;
%%
addpath(genpath('./Read Image'));
addpath(genpath('./Chaotic System'));
addpath(genpath('./Transform'));
addpath(genpath('./Encryption'));
addpath(genpath('./Encoding'));
addpath(genpath('./keys'))
tic


imagePath = './testImage/ruler.512.tiff';
%% 获取密钥，计算图像的SHA-256，key为256位，表示为64位的16进制字符串 
t = [2, 5, 7, 3];
[x0, y0, z0, w0] = getkeys(imagePath, t);


[normalMatrix, suoluetu] = transformTotalImage(imagePath);
oneDimension = reshape(normalMatrix,1,[]);
[H, W] = size(normalMatrix);                                %图片的高宽

afterDC = DC_Code(oneDimension);                            %直流编码，得到的是cell

%% 生成4维混沌序列
SUM = H * W;                                                %图像总像素个数

%根据初值，求解Chen氏超混沌系统，得到四个混沌序列x, y, z, h, 长度均为SUM
[x, y, z, h] = generateSequences(x0, y0, z0, w0, SUM);
%% 对DC编码后的部分进行混沌系统的扩散
DC_Encrytion = Diffusion(afterDC, x);

%% 对缩略图进行变换，取得四个子带LT, RT, LB, RB
[LT, RT, LB, RB] = getFour(suoluetu);
[s_H, s_W] = size(RT);                                      %子块的长宽
nums = s_H * s_H;                                           %子块的像素个数

seq = ones(1, nums * 3);                                    %将RT, LB, RB三个子带展开成一维并拼接在一起
seq(1: nums) = reshape(RT, 1, []);
seq(nums + 1: nums * 2) = reshape(LB, 1, []);
seq(nums * 2 + 1: nums * 3) = reshape(RB, 1, []);
%% 对三个子带进行DNA加密                             

% 取四个混沌序列中的y和z, 将y的前n项作为DNA加密序列，z的前n项位DNA解密序列，y和z的后n项位DNA异或序列
n = nums * 3;
y_E = y(1: n);                                              %DNA编码
z_D = z(1: n);                                              %DNA解码

y_Xor = y(SUM - floor(n / 2) + 1: SUM);                     %DNA异或
z_Xor = z(SUM - ceil(n / 2) + 1: SUM);
y_z_Xor = [y_Xor z_Xor];
Xor_M = sort(y_z_Xor);

for i = 1: nums * 3
    y_E(i) = mod(round(y_E(i) * 10^4), 8) + 1;
    z_D(i) = mod(round(z_D(i) * 10^4), 8) + 1;
    y_z_Xor(i) = mod(round(y_z_Xor(i) * 10^4), 4) + 1;
    Xor_M(i) = mod(round(Xor_M(i) * 10^5), 256);
end
%DNA编码
seqDNA = ones(1, nums * 3 * 4);                             %三个子带内的值均位8位，DNA长度需要乘以4
Xor_M_DNA = ones(1, nums * 3 * 4);
for i = 1: nums * 3
    if i == 1
        seqDNA(1: 4) = DNAEncoding(seq(i), y_E(i));
        Xor_M_DNA(1: 4) = DNAEncoding(Xor_M(i), y_E(i));
    else
        seqDNA(4 * (i - 1) + 1: 4 * i) = DNAEncoding(seq(i), y_E(i));
        Xor_M_DNA(4 * (i - 1) + 1: 4 * i) = DNAEncoding(Xor_M(i), y_E(i));
    end
end
%DNA异或
seqDNA_Xor = ones(1, nums * 3 * 4);
for i = 1: nums * 3 * 4
    if i <= n
        seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i));
    elseif i <= 2 * n
        seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - n));
    elseif i <= 3 * n
        seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 2*n));
    else
        seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 3*n));
%     else
%         seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 4 * n));
    end
end
%DNA解密
seqAfterDNA = ones(1, nums * 3);
for i = 1: nums * 3
    if i == 1
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(1: 4), z_D(i));
    else
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(4 * (i - 1) + 1: 4 * i), z_D(i));
    end
end

%% 对LT进行高低位加密   H * W为原图像的尺寸, LT尺寸为 H / 16 * W / 16  LT各个元素为8位数, 全程计算为列向量
LT_H = s_H;
LT_W = s_W;
LT_Len = LT_H * LT_W;
%x序列取LT_H个，y序列取LT_W个，相乘得到置乱序列A
x_P = x(LT_H + 1: LT_H * 2);
y_P = y(LT_H + 1: LT_H * 2);
A = x_P' * y_P;
A = reshape(A, 1, []);
A = mod(floor(A*power(10,15)), 16);
A = sort_S(A);
%z序列取LT_H个，h序列取LT_W个，相乘得到扩散序列B
z_P = z(LT_H + 1: LT_H * 2);
h_P = h(LT_H + 1: LT_H * 2);
B = z_P' * h_P;
B = reshape(B, 1, []);
B = mod(floor(B*power(10,16)), 1024);
D_r = B(1: LT_Len / 2);%用来做行扩散，每行共N个元素
D_c = B(1 + LT_Len / 2: end);%用来进行列扩散，每列共M个元素

% 将图像分为高4位和低4位，分别用十进制表示
LT_Bin = de2bi(LT, 8,'left-msb');                            %按列转换，每一行为8位二进制
LT_Bin_H = LT_Bin(:, 5: 8);
LT_Bin_L = LT_Bin(:, 1: 4);
LT_h = bi2de(LT_Bin_H, 'left-msb');
% LT_h = reshape(LT_h, LT_H, LT_W);                             %高4位10进制矩阵
LT_l = bi2de(LT_Bin_L, 'left-msb');
% LT_l = reshape(LT_l, LT_H, LT_W);                             %低4位10进制矩阵

% 1. 利用高位图像扰乱低位图像
LT_l1 = zeros(LT_Len, 1); 
LT_l1(1) = mod(LT_h(1)+LT_l(1), 16);                        %4位数是16
for n = 2: LT_Len
    temp = mod(LT_h(n) + LT_l(n), 16);
    LT_l1(n) = bitxor(temp, LT_l1(n - 1)); %最后的低位矩阵
end

% 2. 利用序列A置乱高位图像
LT_h1 = zeros(LT_Len, 1);
for  n = 1: LT_Len
    LT_h1(n) = LT_h(A(n));%置乱后的高位图像
end 

% 3. 将LT_l1转换为4比特的二进制，再将相邻两位合并转成一个十进制数得到LT_l2，利用序列B对LT_l2进行扩散操作。
temp = de2bi(LT_l1, 4,'left-msb');
LT_l2 = zeros(LT_Len / 2, 1);
for i = 1: 2: LT_Len
    t = [temp(i, :) temp(i + 1, :)];
    LT_l2((i + 1) / 2) = bi2de(t, 'left-msb');
end
% D_r扩散
LT_l21 = zeros(LT_Len / 2, 1);
LT_l21(1) = mod(LT_l2(1) + D_r(1), 256);
for i = 2: LT_Len / 2
    temp = mod(LT_l2(i) + D_r(i), 256);
    LT_l21(i) = bitxor(temp, LT_l21(i - 1));
end
% D_c扩散
LT_l22 = zeros(LT_Len / 2, 1);
LT_l22(LT_Len / 2) = mod(LT_l21(LT_Len / 2) + D_c(LT_Len / 2), 256);
for i = LT_Len / 2 - 1: -1: 1
    temp = mod(LT_l21(i) + D_c(i), 256);
    LT_l22(i) = bitxor(temp, LT_l22(i + 1));
end
% 将8位数恢复成4位数，得到LT_l3
LT_l3 = zeros(LT_Len, 1);
temp = de2bi(LT_l22, 8,'left-msb');
for i = 1: LT_Len / 2
    LT_l3(i * 2 - 1) = bi2de(temp(i, 1: 4), 'left-msb');
    LT_l3(i * 2) = bi2de(temp(i, 5: 8), 'left-msb');
end

%% 4. 用LT_l3扰乱LT_h1, 异或得到LT_h2
LT_h2 = bitxor(LT_l3, LT_h1);

%% 5. 将LT_h2, LT_l3按索引分位奇, 偶序列, 将高位的奇和低位的偶互换。
[G_H,H_H] = split_GH(LT_h2);%将高位图像分奇偶列
[G_L,H_L] = split_GH(LT_l3);%将低位图像分奇偶列
%进行交换
H_l = G_H;
G_h = H_L;

LT_h3 = merge_G_H(G_h, H_H)';
LT_l4 = merge_G_H(G_L,H_l)';
%% 6. 将LT_h3, LT_l4合并成8位的LT_E
temp1 = de2bi(LT_h3, 4,'left-msb');
temp2 = de2bi(LT_l4, 4,'left-msb');
LT_E = ones(LT_Len, 1);
for i = 1: LT_Len
    t = [temp1(i, :) temp2(i, :)];
    LT_E(i) = bi2de(t, 'left-msb');
end
LT_E = reshape(LT_E, LT_H, LT_W);

suoluetu_E = [reshape(LT_E, 1, []) seqAfterDNA];

%% 加密图像展示
suoluetu_E_S = reshape(suoluetu_E, LT_H * 2, []);

DC_len = length(DC_Encrytion);
DC_image = ones(1, DC_len);
for i = 1: DC_len
    DC_image(i) = bit2int(DC_Encrytion{i}', length(DC_Encrytion{i}));
end
image_E = [suoluetu_E DC_image];
imshow(reshape(image_E, H, []),[])
%% 逆过程

% c = DC_DeCode(x);
% d = reshape(c, H, W);
% % length(x)
% b = invTransformTotalImage(d,suoluetu);
% imshow(b,[])

%% 程序运行时间与各项指标
toc
%disp(['运行时间: ',num2str(toc)]);