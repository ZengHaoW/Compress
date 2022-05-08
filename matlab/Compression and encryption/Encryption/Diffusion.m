function [result] = Diffusion(DC_Code,sequences)
%DIFFUSION DC编码后进行扩散，DC_Code是cell
%   此处显示详细说明
    len = length(DC_Code);
    % 把序列sequences转化位0~255的整数
    sequences = floor(mod((sequences * 10^10), 256));
    % sequences转为2进制
    sequences_bin = de2bi(sequences, 'left-msb');

    result = cell(1, len);

    for i = 1: len
        t_len = length(DC_Code{i});
        temp = sequences_bin(i, :);
        if t_len > 8
            temp2 = [temp temp];
            result{i} = bitxor(DC_Code{i}, temp2(end - t_len + 1: end));
        else
            result{i} = bitxor(DC_Code{i}, temp(end - t_len + 1: end));
        end

    end

end

