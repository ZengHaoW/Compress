clear;clc;
%%
addpath(genpath('./Read Image'));
addpath(genpath('./Chaotic System'));
addpath(genpath('./Transform'));
addpath(genpath('./Encryption'));
addpath(genpath('./Encoding'));
addpath(genpath('./keys'))


%% 读取加密数据
data_Path = './encryption.bin';
fid = fopen(data_Path);
encryptionData = fread(fid)';
fclose(fid);
keys = readcell('./key.txt');
%% 获取密钥，生成混沌系统的初值
imagePath = keys{7};
t_key = [keys{1}, keys{2}, keys{3}, keys{4}];
% t_key(1) = 2;
% keys{5}(end - 5:end - 5) = '0';
tic
[x0, y0, z0, w0] = getkeys(keys{5}, t_key);
last = keys{6};       %加密数据最后一位是4位，不是八位
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
%% 剪裁和噪声
% 1. 剪裁
% nosiy_len = round(0.5 * suoluetu_len);
% suoluetu(length(suoluetu) / 4: length(suoluetu) / 4 * 2) = 255;
% suoluetu(1 + 1024: 256 + 1024) = 0;
% suoluetu(1 + 1024 * 2 + 256: 256 + 1024 * 2) = 0;
% suoluetu(1 + 1024* 3 + 256: 256 + 1024* 3) = 0;
% 2. 噪声
% suoluetu = double(imnoise(uint8(suoluetu),'salt & pepper',0.1));

%%
DC = encryptionData(suoluetu_len + 1: end);


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
seq = seqAfterDNA;      % 解密的RT, LB, RB三个子带
% fid = fopen('./DNA.bin');
% DNA_RAW = fread(fid)';
% fclose(fid);
% isequal(DNA_RAW, seq)

%% 解密LT_E
LT_Len = LT_H * LT_W;
x_P = x(LT_H + 1: LT_H + LT_H * LT_H);
y_P = y(LT_H + 1: LT_H + LT_H * LT_H);
x_P = floor(mod((x_P * 10^10), 1024));
y_P = floor(mod((y_P * 10^10), 1024));
% 置乱序列A
A = bitxor(x_P, y_P);
A = reshape(A, 1, []);
A = sort_S(A);

z_P = z(LT_H + 1: LT_H + LT_H * LT_H);
h_P = h(LT_H + 1: LT_H + LT_H * LT_H);
z_P = floor(mod((z_P * 10^10), 256));
h_P = floor(mod((h_P * 10^10), 256));
B = bitxor(z_P, h_P);
B = reshape(B, 1, []);

D_r = B(1: LT_Len / 2);%用来做行扩散，每行共N个元素
D_c = B(1 + LT_Len / 2: end);%用来进行列扩散，每列共M个元素

%% 1. 将LT_E分割成LT_h3, LT_l4
% 将图像分为高4位和低4位，分别用十进制表示
LT_Bin = de2bi(LT_E, 8,'left-msb');                            %按列转换，每一行为8位二进制
LT_Bin_H = LT_Bin(:, 1: 4);
LT_Bin_L = LT_Bin(:, 5: 8);

LT_h3 = bi2de(LT_Bin_H, 'left-msb');
LT_l4 = bi2de(LT_Bin_L, 'left-msb');



%% 2. 将LT_h3, LT_l4按索引分位奇, 偶序列, 将高位的奇和低位的偶互换得到将LT_h2，将LT_l3
[G_H,H_H] = split_GH(LT_h3);%将高位图像分奇偶列
[G_L,H_L] = split_GH(LT_l4);%将低位图像分奇偶列
%进行交换
H_l = G_H;
G_h = H_L;

LT_h2 = merge_G_H(G_h, H_H)';
LT_l3 = merge_G_H(G_L,H_l)';

%% 3. 用LT_l3扰乱LT_h2, 异或得到LT_h1
LT_h1 = bitxor(LT_l3, LT_h2);
%% 4. 将LT_l3转换为4比特的二进制，再将相邻两位合并转成一个十进制数得到LT_l2，利用序列B对LT_l2进行扩散操作得到LT_l1.
temp = de2bi(LT_l3, 4,'left-msb');
LT_l2 = zeros(LT_Len / 2, 1);
for i = 1: 2: LT_Len
    t = [temp(i, :) temp(i + 1, :)];
    LT_l2((i + 1) / 2) = bi2de(t, 'left-msb');
end

% D_c扩散
LT_l22 = zeros(LT_Len / 2, 1);
for i = 1 : LT_Len / 2 - 1
    temp = bitxor(LT_l2(i), LT_l2(i + 1));
    LT_l22(i) = mod(temp - D_c(i), 256);
end
LT_l22(LT_Len / 2) = mod(LT_l2(LT_Len / 2) - D_c(LT_Len / 2), 256);



% D_r扩散
LT_l21 = zeros(LT_Len / 2, 1);

for i = LT_Len / 2: -1: 2
    temp = bitxor(LT_l22(i), LT_l22(i - 1));
    LT_l21(i) = mod(temp - D_r(i), 256);
end
LT_l21(1) = mod(LT_l22(1) - D_r(1), 256);


% 将8位数恢复成4位数，得到LT_l1
LT_l1 = zeros(LT_Len, 1);
temp = de2bi(LT_l21, 8,'left-msb');
for i = 1: LT_Len / 2
    LT_l1(i * 2 - 1) = bi2de(temp(i, 1: 4), 'left-msb');
    LT_l1(i * 2) = bi2de(temp(i, 5: 8), 'left-msb');
end
% fid = fopen('./LT_l1.bin');
% qwe = fread(fid)';
% fclose(fid);
% isequal(qwe, LT_l1')
%% 5. 利用序列A置乱高位图像LT_h1得到LT_h
LT_h = zeros(LT_Len, 1);
for  n = 1: LT_Len
    LT_h(A(n)) = LT_h1(n);%置乱后的高位图像
end 
%% 6. 利用高位图像扰乱低位图像LT_l1得到LT_l
LT_l = zeros(LT_Len, 1);

for i = LT_Len: -1: 2
    temp = bitxor(LT_l1(i), LT_l1(i - 1));

    LT_l(i) = mod(temp - LT_h(i), 16);
end
LT_l(1) = mod(LT_l1(1) - LT_h(1), 16);                       

%% 7. 将高低位LT_h,LT_l合并得到LT
temp2 = de2bi(LT_h, 4,'left-msb');
temp1 = de2bi(LT_l, 4,'left-msb');
LT = ones(LT_Len, 1);
for i = 1: LT_Len
    t = [temp1(i, :) temp2(i, :)];
    LT(i) = bi2de(t, 'left-msb');
end


% fid = fopen('./LT.bin');
% qwe = fread(fid)';
% fclose(fid);
% isequal(qwe, LT')

%% 获得缩略图
% LT 是对的， seq也是对的
LT = reshape(LT, LT_H, LT_W);
RT = seq(1: nums);
RT = reshape(RT, LT_H, LT_W);
LB = seq(nums + 1: nums * 2);
LB = reshape(LB, LT_H, LT_W);
RB = seq(nums * 2 + 1: nums * 3);
RB = reshape(RB, LT_H, LT_W);
suoluetu_R = getFourInv(LT, RT, LB, RB);        



%% 展示解密图片
% fid = fopen('./suoluetu.bin');
% qwe = fread(fid)';
% fclose(fid);
% isequal(qwe, reshape(suoluetu_R, 1, []))
figure, imshow(suoluetu_R,[])
imwrite(uint8(suoluetu_R), './testImage/black/black_suoluetu.tiff','Compression','none');
toc
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
toc
DC_Code = Diffusion(DC_Code, x);
toc
d = DC_DeCode(DC_Code);                     %d写错了
toc
d = reshape(d, image_H, image_W);

% imshow(d, [])
b = invTransformTotalImage(d,suoluetu_R);

figure, imshow(b, [])

bb = readImage(imagePath);
% imwrite(uint8(b), './testImage/lena_anti_noise_0.3.tiff','Compression','none');
an = isequal(bb, b);
if an == 1
    disp("解密图像和原图像完全一致");
else
    disp("解密图像和原图像不一致");
end



