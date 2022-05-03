 function [result] = DC_DeCode(DC_CodeData)
%DC_DECODE 还原DC编码
%   此处显示详细说明
    level = [2 3 4 5 6];
    dataLength = length(DC_CodeData);
    t = ones(1, 8); %用来异或补码
    result = ones(1, dataLength);
    r_index = 1;
    index = 1;
    while index < dataLength
        for i = 1: 5
            classLevel =  DC_TableDeCode(DC_CodeData(index: index + level(i) - 1));
            if classLevel > -1
                if classLevel == 0
                    index = index + level(i);
                    result(r_index) = 0;
                    r_index = r_index + 1;
                    break
                else
                    index = index + level(i);
                    temp = DC_CodeData(index: index + classLevel - 1);
                    index = index + classLevel;
                    if temp(1) == 0 %负数
                        temp = bitxor(temp, t(1:classLevel));  %补码转为正数
                        temp = reshape(temp, [], 1);   %bit2int 需要列向量
                        temp_int = bit2int(temp, classLevel) * -1;
                    else %正数
                        temp = reshape(temp, [], 1);   %bit2int 需要列向量
                        temp_int = bit2int(temp, classLevel);
                    end
                    result(r_index) = temp_int;
                    r_index = r_index + 1;
                    break
                end
            end
        end
    end
    result = result(1: r_index - 1);
end

