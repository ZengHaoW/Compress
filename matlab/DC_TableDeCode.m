function [classLevle] = DC_TableDeCode(DC_CodeData)
%DC_DECODE 此处显示有关此函数的摘要
%   此处显示详细说明
    if isequal(DC_CodeData, [0 0])  %0
        classLevle = 0;
    elseif isequal(DC_CodeData, [0 1 0])   %-1,1
        classLevle = 1;
    elseif isequal(DC_CodeData, [0 1 1])   % < 4    
        classLevle = 2;
    elseif isequal(DC_CodeData, [1 0 0])    % < 8
        classLevle = 3;
    elseif isequal(DC_CodeData, [1 0 1])
        classLevle = 4;
    elseif isequal(DC_CodeData, [1 1 0])
        classLevle = 5;
    elseif isequal(DC_CodeData, [1 1 1 0])
        classLevle = 6;
    elseif isequal(DC_CodeData, [1 1 1 1 0])
        classLevle = 7;
    elseif isequal(DC_CodeData, [1 1 1 1 1 0])
        classLevle = 8;
    else
        classLevle = -1;
    end
end

