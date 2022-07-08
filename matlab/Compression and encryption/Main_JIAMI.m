clear;clc;
addpath(genpath('./Read Image'));
addpath(genpath('./Chaotic System'));
addpath(genpath('./Transform'));
addpath(genpath('./Encryption'));
addpath(genpath('./Encoding'));
addpath(genpath('./keys'))

imagePath = './testImage/black.tiff';
I = readImage(imagePath);
t_key = [2, 5, 7, 2];
        
%% 生成密钥，根据密钥生成四维混沌序列的初值
keys = sha256(I);
[x0, y0, z0, w0] = getkeys(keys, t_key);
%% 读取图片做差值变换一，变换后展开成一维向量做DC编码
I = readImage(imagePath);
[vdt_image, suoluetu] = transformTotalImage(I);
imwrite(uint8(suoluetu), './data/black/suoluetu.tiff','Compression','none');
oneDimension = reshape(vdt_image, 1, []);
DC_Code_Data = DC_Code(oneDimension);
%% 生成四维混沌序列x,y,z,h
[H, W] = size(I);
%混沌序列个数
SUM = H * W;
%根据初值，求解Chen氏超混沌系统，得到四个混沌序列x, y, z, h, 长度均为SUM
[x, y, z, h] = generateSequences(x0, y0, z0, w0, SUM);
%% 加密
DC_Encrytion = Diffusion(DC_Code_Data, x);

suoluetu_E = Suoluetu_JIAMI(suoluetu, x, y, z, h);
% suoluetu_E = Suoluetu_JIAMI(suoluetu_E, x, y, z, h);
% sss = Suoluetu_JIEMI(suoluetu_E,x,y,z,h);

% [npcr, uaci] = NPCR_UACI(suoluetu_E,suoluetu_E_1)
%% NPCR
clc;
I_P = I;
npcr_total = 0;
uaci_total = 0;
for i = 1: 10
    for j = 1: 10
        I_P(i,j) = mod(I(i,j)+1,256);
        keys = sha256(I_P);
        [x0, y0, z0, w0] = getkeys(keys, t_key);
        [vdt_image, suoluetu] = transformTotalImage(I);

        [x, y, z, h] = generateSequences(x0, y0, z0, w0, SUM);
        suoluetu_E_P = Suoluetu_JIAMI(suoluetu, x, y, z, h);
        [npcr, uaci] = NPCR_UACI(suoluetu_E, suoluetu_E_P);
        npcr_total = npcr_total + npcr;
        uaci_total = uaci_total + uaci;
    end
end
npcr_real = npcr_total / 100
uaci_real = uaci_total / 100
%% 保存密钥和加密数据
save('suoluetu_E', 'suoluetu_E')
save('total_E', "DC_Encrytion");
save('sha256_keys', "keys");
save('t_keys', "t_key");
% imwrite(uint8(suoluetu_E), './data/Airplane (U-2)/suoluetu_E.tiff','Compression','none');
%% 计算压缩率
clc;
original_length = SUM * 8
suoluetu_length = original_length / 64

compress_length = length(DC_Encrytion)
cr = original_length / compress_length
%% 信息熵
suoluetu_Entropy = Entropy(suoluetu)
suoluetu_E_Entropy = Entropy(suoluetu_E)
%% 计算NPCR和UACI
clc;
suoluetu_P = suoluetu;
npcr_total = 0;
uaci_total = 0;
for i = 1: 1
    for j = 1: 1
    suoluetu_P(i, j) = 255;
    suoluetu_E_P = Suoluetu_JIAMI(suoluetu_P, x, y, z, h);
    [npcr, uaci] = NPCR_UACI(suoluetu_E, suoluetu_E_P);
    npcr_total = npcr_total + npcr;
    uaci_total = uaci_total + uaci;
    end
end
npcr_real = npcr_total / 1
uaci_real = uaci_total / 1