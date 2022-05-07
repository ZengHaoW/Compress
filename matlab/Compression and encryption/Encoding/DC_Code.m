function [result] = DC_Code(oneDimensionData)
%DC_CODE 返回的是cell
%   此处显示详细说明
    [~, dataLength] = size(oneDimensionData);
    %%
%     count = 0;
%     for i = 1: dataLength
%         temp_abs = abs(oneDimensionData(i));
%             if temp_abs == 0
%                 l = 2+1;
%             elseif temp_abs < 2
%                 l = 3 + 1;
%             elseif temp_abs < 4
%                 l = 3+2;
%             elseif temp_abs < 8
%                 l = 3+3;
%             elseif temp_abs < 16
%                 l = 3+4;
%             elseif temp_abs < 32
%                 l = 3 + 5;
%             elseif temp_abs < 64
%                 l = 4 + 6;
%             elseif temp_abs < 128
%                 l = 5 + 7;
%             else
%                 l = 6 + 8;
%             end
%         count = count + l;
%     end
    %%
    afterCode = ones(1, dataLength * 8);
    total_length = 1;
    result = cell(1, dataLength);
    for i=1:dataLength
        if oneDimensionData(i) < 0  %小于零的先转补码
            temp_abs = abs(oneDimensionData(i));
            if temp_abs < 2
                l = 1;
            elseif temp_abs < 4
                l = 2;
            elseif temp_abs < 8
                l = 3;
            elseif temp_abs < 16
                l = 4;
            elseif temp_abs < 32
                l = 5;
            elseif temp_abs < 64
                l = 6;
            elseif temp_abs < 128
                l = 7;
            else
                l = 8;
            end
            temp = bitcmp(temp_abs, 'uint8');
            temp = de2bi(temp, 8,'left-msb');
            temp = temp(9-l:8);
            tempAfterCode = [DC_Table(temp_abs), temp];
            result{i} = tempAfterCode;
%             [~, temp_length] =  size(tempAfterCode);
%             afterCode(total_length: total_length + temp_length - 1) = tempAfterCode;
%             total_length = total_length + temp_length;
        else
            temp = oneDimensionData(i);
            if temp == 0
                tempAfterCode = DC_Table(temp);
            else
                tempAfterCode = [DC_Table(temp), de2bi(temp, 'left-msb')];
            end
            result{i} = tempAfterCode;
%             [~, temp_length] =  size(tempAfterCode);
%             afterCode(total_length: total_length + temp_length - 1) = tempAfterCode;
%             total_length = total_length + temp_length;
        end
    end
%     afterCode = afterCode(1: total_length - 1);
%     afterCode = cell2mat(result);
end

