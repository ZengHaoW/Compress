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
DNA_Code = suoluetu(LT_H * LT_H + 1: end);
%% 解密DNA_Code，得到RT, LB, RB








