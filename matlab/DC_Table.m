function [result] = DC_Table(nums)
%UNTITLED 根据输入获取对应的DC表值
%   此处显示详细说明
    if nums == 0
        result = [0 0];
    elseif nums == 1
        result = [0 1 0];
    elseif nums < 4
        result = [0 1 1];
    elseif nums < 8
        result = [1 0 0];
    elseif nums < 16
        result = [1 0 1];
    elseif nums < 32
        result = [1 1 0];
    elseif nums < 64
        result = [1 1 1 0];
    elseif nums < 128
        result = [1 1 1 1 0];
    else
        result = [1 1 1 1 1 0];
    end
end

