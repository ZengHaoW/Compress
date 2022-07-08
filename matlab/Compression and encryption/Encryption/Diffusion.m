function [result] = Diffusion(DC_Code,sequences)
%DIFFUSION DC编码后进行扩散，DC_Code是cell
%   此处显示详细说明
%     DC_Code = cell2mat(DC_Code);
    len = length(DC_Code);
    % 把序列sequences转化位0~255的整数
    sequences = floor(mod((sequences * 10^10), 256));
    % sequences转为2进制
    sequences_bin = de2bi(sequences, 'left-msb');
    sequences_bin = reshape(sequences_bin, 1, []);
    
    result = bitxor(DC_Code, sequences_bin(1:len));

end

