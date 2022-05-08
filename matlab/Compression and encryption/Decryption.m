clear;clc;
%%
addpath(genpath('./Read Image'));
addpath(genpath('./Chaotic System'));
addpath(genpath('./Transform'));
addpath(genpath('./Encryption'));
addpath(genpath('./Encoding'));
addpath(genpath('./keys'))
tic

%% 读取加密数据
data_Path = './encryption.bin';
fid = fopen(data_Path);
encryptionData = fread(fid)';
fclose(fid);
%% 获取密钥，生成混沌系统的初值
imagePath = './testImage/lena_gray.bmp';
t_key = [2, 5, 7, 2];
I = imread(imagePath);
keys = sha256(I);
[x0, y0, z0, w0] = getkeys(keys, t_key);
last = 4;       %加密数据最后一位是4位，不是八位
image_H = 512;  %提取数据需要原图像的尺寸
image_W = 512;  
%% 生成混沌序列
SUM = image_H * image_W;                                                %图像总像素个数

%根据初值，求解Chen氏超混沌系统，得到四个混沌序列x, y, z, h, 长度均为SUM
[x, y, z, h] = generateSequences(x0, y0, z0, w0, SUM);
%% 将缩略图从加密数据中分离出来
% 缩略图尺寸
suoluetu_H = image_H / 8;
suoluetu_W = image_W / 8;
suoluetu_len = suoluetu_H * suoluetu_W;

suoluetu = encryptionData(1: suoluetu_len);
DC = encryptionData(suoluetu_len + 1: end);
%% DC编码部分转二进制，注意最后一位数的位长
DC_Code = cell(1, length(DC));
if last > 0
    DC_Code{end} = de2bi(DC(end), last,'left-msb');
    for i = 1: length(DC) - 1
        DC_Code{i} = de2bi(DC(i), 8,'left-msb');
    end
else
    for i = 1: length(DC)
        DC_Code{i} = de2bi(DC(i), 8,'left-msb');
    end
end
% 将DC_Code部分解密
DC_Code = Diffusion(DC_Code, x);
d = DC_DeCode(DC_Code);
%% 取得缩略图的四个子带LT, RT, LB, RB
LT_H = image_H / 8 / 2;
LT_W = image_W / 8 / 2;

LT_E = suoluetu(1: LT_H * LT_H);
seqAfterDNA = suoluetu(LT_H * LT_H + 1: end);
%% 对RT, LB, RB三个子带进行解密(DNA)
% 取四个混沌序列中的y和z, 将y的前n项作为DNA加密序列，z的前n项位DNA解密序列，y和z的后n项位DNA异或序列
nums = LT_H * LT_W;
n = nums * 3;
y_E = y(1: n);                                              %DNA编码
z_D = z(1: n);                                              %DNA解码
% z_D = y_E;

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
% fid=fopen("./DNAafter.bin");
% DNA_RAW = fread(fid)';
% fclose(fid);
% isequal(DNA_RAW, seqAfterDNA)
% seqAfterDNA = DNA_RAW;
%%
for i = 1: nums * 3
    if i == 1
        seqDNA(1: 4) = DNAEncoding(seqAfterDNA(i), z_D(i));
        Xor_M_DNA(1: 4) = DNAEncoding(Xor_M(i), y_E(i));
    else
        seqDNA(4 * (i - 1) + 1: 4 * i) = DNAEncoding(seqAfterDNA(i), z_D(i));
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
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(1: 4), y_E(i));
    else
        seqAfterDNA(i) = DNADecoding(seqDNA_Xor(4 * (i - 1) + 1: 4 * i), y_E(i));
    end
end
seq = seqAfterDNA;
% fid = fopen('./DNA.bin');
% DNA_RAW = fread(fid)';
% fclose(fid);
% isequal(DNA_RAW, seq)

%% 解密LT
%%
toc


