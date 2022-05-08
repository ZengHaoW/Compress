function [result] = Diffusion2(DC_Code,sequences)
%DIFFUSION DC编码后进行扩散
%   此处显示详细说明
    len = length(DC_Code);
    s_len = length(sequences);
    % 把序列sequences转化位0~255的整数
    sequences = floor(mod((sequences * 10^10), 256));
    % sequences转为2进制
    sequences_bin = de2bi(sequences, 'left-msb');
    for i = 1: s_len
        sequences(i) = floor(((sequences(i) - s_Min) / SUM) * 255); %归一化到0~255
        
    end
    result = bitxor(DC_Code, seq(1: len));
end

