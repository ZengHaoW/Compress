function [encryptedImage, suoluetu_E] = JIAMI(imagePath, t_key)
%UNTITLED2 加密图像算法
    %% 添加路径
    addpath(genpath('./Read Image'));
    addpath(genpath('./Chaotic System'));
    addpath(genpath('./Transform'));
    addpath(genpath('./Encryption'));
    addpath(genpath('./Encoding'));
    addpath(genpath('./keys'))
    %% 生成密钥，根据密钥生成四维混沌序列的初值
    I = imread(imagePath);
    keys = sha256(I);
    [x0, y0, z0, w0] = getkeys(keys, t_key);
    %% 读取图片做差值变换一，变换后展开成一维向量做DC编码
    I = readImage(imagePath);
    [vdt_image, suoluetu] = transformTotalImage(I);
    oneDimension = reshape(vdt_image, 1, []);
    DC_Code_Data = DC_Code(oneDimension);
%     DC_Code_inv = DC_DeCode(cell2mat(DC_Code_Data));
    %% 生成四维混沌序列x,y,z,h
    [H, W] = size(I);
    %混沌序列个数
    SUM = H * W;                                               
    %根据初值，求解Chen氏超混沌系统，得到四个混沌序列x, y, z, h, 长度均为SUM
    [x, y, z, h] = generateSequences(x0, y0, z0, w0, SUM);
    %% 对压缩后数据做流密码加密
    DC_Encrytion = Diffusion(DC_Code_Data, x);
    %% 对缩略图做差值变换二，取得四个子带LT, RT, LB, RB
    suoluetu(55,55) = 0;
    [LT, RT, LB, RB] = getFour(suoluetu);
    [s_H, s_W] = size(RT);                                      %子块的长宽
    nums = s_H * s_H;                                           %子块的像素个数
    
    seq = ones(1, nums * 3);                                    %将RT, LB, RB三个子带展开成一维并拼接在一起
    seq(1: nums) = reshape(RT, 1, []);
    seq(nums + 1: nums * 2) = reshape(LB, 1, []);
    seq(nums * 2 + 1: nums * 3) = reshape(RB, 1, []);
    %% 对RT, LB, RB做DNA加密
    % 取四个混沌序列中的y和z, 将y的前n项作为DNA加密序列，z的前n项位DNA解密序列，y和z的后n项位DNA异或序列
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
    seqDNA_Xor(1) = DNA_diffusion(seqDNA(1), Xor_M_DNA(1), y_z_Xor(1));
    for i = 2: nums * 3 * 4
        if i <= n
            seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i));
            seqDNA_Xor(i) = DNA_diffusion(seqDNA_Xor(i), seqDNA_Xor(i-1), y_z_Xor(i));
        elseif i <= 2 * n
            seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - n));
            seqDNA_Xor(i) = DNA_diffusion(seqDNA_Xor(i), seqDNA_Xor(i-1), y_z_Xor(i - n));
        elseif i <= 3 * n
            seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 2*n));
            seqDNA_Xor(i) = DNA_diffusion(seqDNA_Xor(i), seqDNA_Xor(i-1), y_z_Xor(i - 2*n));
        else
            seqDNA_Xor(i) = DNA_diffusion(seqDNA(i), Xor_M_DNA(i), y_z_Xor(i - 3*n));
            seqDNA_Xor(i) = DNA_diffusion(seqDNA_Xor(i), seqDNA_Xor(i-1), y_z_Xor(i - 3*n));
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
    
    % x_P = x(LT_H + 1: LT_H * 2);
    % y_P = y(LT_H + 1: LT_H * 2);
    % A = x_P' * y_P;
    % A = reshape(A, 1, []);
    
    x_P = x(LT_H + 1: LT_H + LT_H * LT_H);
    y_P = y(LT_H + 1: LT_H + LT_H * LT_H);
    x_P = floor(mod((x_P * 10^10), 1024));
    y_P = floor(mod((y_P * 10^10), 1024));
    
    A = bitxor(x_P, y_P);
    A = reshape(A, 1, []);
    
    % A = mod(floor(A*power(10,15)), 16);
    A = sort_S(A);
    % A = mod(floor(A*power(10,15)), 1024);
    % S_A = sort(A);
    % [~, A] = ismember(S_A, A);
    %z序列取LT_H个，h序列取LT_W个，相乘得到扩散序列B
    
    % z_P = z(LT_H + 1: LT_H * 2);
    % h_P = h(LT_H + 1: LT_H * 2);
    % B = z_P' * h_P;
    % B = reshape(B, 1, []);
    % B = mod(floor(B*power(10,16)), 256);
    
    z_P = z(LT_H + 1: LT_H + LT_H * LT_H);
    h_P = h(LT_H + 1: LT_H + LT_H * LT_H);
    z_P = floor(mod((z_P * 10^10), 256));
    h_P = floor(mod((h_P * 10^10), 256));
    B = bitxor(z_P, h_P);
    B = reshape(B, 1, []);
    
    D_r = B(1: LT_Len / 2);%用来做行扩散，每行共N个元素
    D_c = B(1 + LT_Len / 2: end);%用来进行列扩散，每列共M个元素
    
    % fid=fopen("./LT.bin","wb");
    % fwrite(fid,reshape(LT, 1,[]),'uint8');
    % fclose(fid);
    
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
    LT_E = reshape(LT_E, LT_H, LT_W);                                   %将RT, LB, RB三个子带展开成一维并拼接在一起
    RT_E = reshape(seqAfterDNA(1: nums) , LT_H, LT_W);
    LB_E = reshape(seqAfterDNA(nums + 1: nums * 2), LT_H, LT_W);
    RB_E = reshape(seqAfterDNA(nums * 2 + 1: nums * 3), LT_H, LT_W);
    %% 将LT，RT，LB，RB四个子带置乱
    d_x = x(end-(LT_H * LT_W * 3)+1:end);
    d_x= reshape(d_x, [LT_H, LT_W, 3]);
    d_x = floor(mod((d_x * 10^12),3)) + 2;


    suoluetu_E = ones(LT_H, LT_W, 4);
    suoluetu_E(:,:,1) = LT_E;
    suoluetu_E(:,:,2) = RT_E;
    suoluetu_E(:,:,3) = LB_E;
    suoluetu_E(:,:,4) = RB_E;
    for i = 1: LT_H
        for j = 1: LT_W
            for k = 2: 4
            suoluetu_E(i,j,k) = suoluetu_E(i,j,d_x(i,j,k-1));
            end
        end
    end
    %%
    suoluetu_H = H / 8;
    suoluetu_W = W / 8;
    suoluetu_EE = ones(suoluetu_H, suoluetu_W);
    suoluetu_EE(1: LT_H, 1: LT_W) = suoluetu_E(:,:,1);
    suoluetu_EE(1: LT_H, LT_W + 1: LT_W * 2) = suoluetu_E(:,:,2);
    suoluetu_EE(LT_H + 1: LT_H * 2, 1: LT_W) = suoluetu_E(:,:,3);
    suoluetu_EE(LT_H + 1: LT_H * 2, LT_W + 1: LT_W * 2) = suoluetu_E(:,:,4);
    
%     save("./suoluetu_E_1.mat", 'suoluetu_E')
    imwrite(uint8(suoluetu_EE), './suoluetu_E_1P.tiff','Compression','none');
    %% 分别保存密钥，DC加密数据和缩略图加密图像
    

    encryptedImage = invTransformTotalImage(vdt_image);
    suoluetu_E = suoluetu;
end

