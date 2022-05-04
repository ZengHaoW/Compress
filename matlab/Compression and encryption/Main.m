clear;clc;
%%
addpath(genpath('./Read Image'));
addpath(genpath('./Chaotic System'));
addpath(genpath('./Transform'));
addpath(genpath('./Encryption'));
addpath(genpath('./Encoding'));
tic
%% 读取图片，做变换与编码，取出缩略图

imagePath = './testImage/lena_gray.bmp';
[normalMatrix, suoluetu] = transformTotalImage(imagePath);
oneDimension = reshape(normalMatrix,1,[]);
[H, W] = size(normalMatrix);                                %图片的高宽
afterDC = DC_Code(oneDimension);                            %直流编码

%% 生成4维混沌序列
SUM = H * W;                                                %图像总像素个数
I = readImage(imagePath);
%求出四个初值
X0=sum(sum(bitand(I,17)))/(17*SUM);
Y0=sum(sum(bitand(I,34)))/(34*SUM);
Z0=sum(sum(bitand(I,68)))/(68*SUM);
H0=sum(sum(bitand(I,136)))/(136*SUM);
%保留四位小数
X0=round(X0*10^4)/10^4;%作为密钥6
Y0=round(Y0*10^4)/10^4;%作为密钥7
Z0=round(Z0*10^4)/10^4;%作为密钥8
H0=round(H0*10^4)/10^4;%作为密钥10
%根据初值，求解Chen氏超混沌系统，得到四个混沌序列x, y, z, h, 长度均为SUM
[x, y, z, h] = generateSequences(X0, Y0, Z0, H0, SUM);
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
    Xor_M(i) = mod(round(Xor_M(i) * 10^6), 510) + 1;
end
%DNA编码
seqDNA = ones(1, nums * 3 * 5);                             %三个子带内的值均为10位，DNA长度需乘以5
Xor_M_DNA = ones(1, nums * 3 * 5);
for i = 1: nums * 3
    if i == 1
        seqDNA(1: 5) = DNAEncoding(seq(i), y_E(i));
        Xor_M_DNA(1: 5) = DNAEncoding(Xor_M(i), y_E(i));
    else
        seqDNA(5 * (i - 1) + 1: 5 * i) = DNAEncoding(seq(i), y_E(i));
        Xor_M_DNA(5 * (i - 1) + 1: 5 * i) = DNAEncoding(Xor_M(i), y_E(i));
    end
end
%DNA异或
seqDNA_Xor = ones(1, nums * 3 * 5);
for i = 1: nums * 3 * 5
    if i <= n
        seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i));
    elseif i <= 2 * n
        seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - n));
    elseif i <= 3 * n
        seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 2*n));
    elseif i <= 4 * n
        seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 3*n));
    else
        seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 4 * n));
    end
end
%DNA解密
seqAfterDNA = ones(1, nums * 3);
for i = 1: nums * 3
    if i == 1
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(1: 5), z_D(i));
    else
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(5 * (i - 1) + 1: 5 * i), z_D(i));
    end
end

%% 对LT进行高低位加密   H * W为原图像的尺寸, LT尺寸为 H / 16 * W / 16  LT各个元素为10位数, 全程列向量
LT_H = s_H;
LT_W = s_W;
LT_Len = LT_H * LT_W;
%x序列取LT_H个，y序列取LT_W个，相乘得到置乱序列A
x_P = x(LT_H + 1: LT_H * 2);
y_P = y(LT_H + 1: LT_H * 2);
A = x_P' * y_P;
A = reshape(A, 1, []);
A = mod(floor(A*power(10,15)),16);
A = sort_S(A);
%z序列取LT_H个，h序列取LT_W个，相乘得到扩散序列B
z_P = z(LT_H + 1: LT_H * 2);
h_P = h(LT_H + 1: LT_H * 2);
B = z_P' * h_P;
B = reshape(B, 1, []);
B = mod(floor(B*power(10,16)),1024);
D_r = B(1: LT_Len / 2);%用来做行扩散，每行共N个元素
D_c = B(1 + LT_Len / 2: end);%用来进行列扩散，每列共M个元素

% 将图像分为高5位和低5位，分别用十进制表示
LT_Bin = de2bi(LT, 10,'left-msb');                            %按列转换，每一行为10位二进制
LT_Bin_H = LT_Bin(:, 6: 10);
LT_Bin_L = LT_Bin(:, 1: 5);
LT_h = bi2de(LT_Bin_H, 'left-msb');
% LT_h = reshape(LT_h, LT_H, LT_W);                             %高5位10进制矩阵
LT_l = bi2de(LT_Bin_L, 'left-msb');
% LT_l = reshape(LT_l, LT_H, LT_W);                             %低5位10进制矩阵

% 1. 利用高位图像扰乱低位图像
LT_l1 = zeros(LT_Len, 1); 
LT_l1(1) = mod(LT_h(1)+LT_l(1), 32);                        %5位数是32
for n = 2: LT_Len
    temp = mod(LT_h(n) + LT_l(n), 32);
    LT_l1(n) = bitxor(temp, LT_l1(n - 1)); %最后的低位矩阵
end

% 2. 利用序列A置乱高位图像
LT_h1 = zeros(LT_Len, 1);
for  n = 1: LT_Len
    LT_h1(n) = LT_h(A(n));%置乱后的高位图像
end 

% 3. 将LT_l1转换为5比特的二进制，再将相邻两位合并转成一个十进制数得到LT_l2，利用序列B对LT_l2进行扩散操作。
temp = de2bi(LT_l1, 5,'left-msb');
LT_l2 = zeros(LT_Len / 2, 1);
for i = 1: 2: LT_Len
    t = [temp(i, :) temp(i + 1, :)];
    LT_l2((i + 1) / 2) = bi2de(t, 'left-msb');
end
% D_r扩散
LT_l21 = zeros(LT_Len / 2, 1);
LT_l21(1) = mod(LT_l2(1) + D_r(1), 1024);
for i = 2: LT_Len / 2
    temp = mod(LT_l2(i) + D_r(i), 1024);
    LT_l21(i) = bitxor(temp, LT_l21(i - 1));
end
% D_c扩散
LT_l22 = zeros(LT_Len / 2, 1);
LT_l22(LT_Len / 2) = mod(LT_l21(LT_Len / 2) + D_c(LT_Len / 2), 1024);
for i = LT_Len / 2 - 1: -1: 1
    temp = mod(LT_l21(i) + D_c(i), 1024);
    LT_l22(i) = bitxor(temp, LT_l22(i + 1));
end
% 将10位数恢复成5位数，得到LT_l3
LT_l3 = zeros(LT_Len, 1);
temp = de2bi(LT_l22, 10,'left-msb');
for i = 1: LT_Len / 2
    LT_l3(i * 2 - 1) = bi2de(temp(i, 1: 5), 'left-msb');
    LT_l3(i * 2) = bi2de(temp(i, 6: 10), 'left-msb');
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
%% 6. 将LT_h3, LT_l4合并成10位的LT_E
temp1 = de2bi(LT_h3, 5,'left-msb');
temp2 = de2bi(LT_l4, 5,'left-msb');
LT_E = ones(LT_Len, 1);
for i = 1: LT_Len
    t = [temp1(i, :) temp2(i, :)];
    LT_E(i) = bi2de(t, 'left-msb');
end
LT_E = reshape(LT_E, LT_H, LT_W);
suoluetu_E = [reshape(LT_E, 1, []) seqAfterDNA];

%% 加密图像展示
DC_length = length(DC_Encrytion);
% suoluetu_E = reshape(suoluetu_E, LT_W * 2, LT_W * 2);
redundant = mod(DC_length, 10);
img_E = ones(1, floor(DC_length / 10) + 1);
for i = 1: floor(DC_length / 10)
    t = DC_Encrytion(10 * (i - 1) + 1: 10 * i);
    img_E(i) = bi2de(t, 'left-msb');
end
img_E(end) = bi2de(DC_Encrytion(end - redundant: end), 'left-msb');
total_E = [suoluetu_E img_E];
total_E = reshape(total_E, 300, []);
imshow(total_E, [])
%% 逆过程

% c = DC_DeCode(x);
% d = reshape(c, H, W);
% % length(x)
% b = invTransformTotalImage(d,suoluetu);
% imshow(b,[])

%% 程序运行时间与各项指标
toc
%disp(['运行时间: ',num2str(toc)]);