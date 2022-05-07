function [result] = Diffusion2(DC_Code,sequences)
%DIFFUSION DC编码后进行扩散
%   此处显示详细说明
    len = length(DC_Code);
    s_len = length(sequences);
    % 把sequences归一化到0~255，且转为二进制
    s_Max = max(sequences);
    s_Min = min(sequences);
    SUM = s_Max - s_Min;
    seq = ones(1, s_len * 8);
    for i = 1: s_len
        sequences(i) = floor(((sequences(i) - s_Min) / SUM) * 255); %归一化到0~255
        
    end
    result = bitxor(DC_Code, seq(1: len));
end

