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

%% 逆过程

% c = DC_DeCode(x);
% d = reshape(c, H, W);
% % length(x)
% b = invTransformTotalImage(d,suoluetu);
% imshow(b,[])

%% 程序运行时间与各项指标
toc
%disp(['运行时间: ',num2str(toc)]);