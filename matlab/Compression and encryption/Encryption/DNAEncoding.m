function [DNA_Code] = DNAEncoding(pixel, nums)
%DNAENCODING 根据nums的值对pixel（1*1）进行DNA编码（1*4） pixel为10位数
%   此处显示详细说明
    a1 = bitand(pixel, 768) / 256;% 取第七和第八比特面
    a2 = bitand(pixel, 192) / 64; % 取第五和第六比特面
    a3 = bitand(pixel, 48) / 16;  % 取第三和第四比特面
    a4 = bitand(pixel, 12)/4;   % 取第一和第二比特面
    a5 = bitand(pixel, 3) / 1;
    A = [a1 a2 a3 a4 a5]; %1 * 8
    t = length(A);
    DNA_Code = ones(1, 4);
    r = ['A' 'T' 'C' 'G'];
    if nums == 1 || nums == 2
        for i = 1: t
            if A(1, i) == 0
                DNA_Code(1, i) = r(1);          %A
            elseif A(1, i) == 3
                DNA_Code(1, i) = r(2);          %T
            elseif A(1, i) == 2
                if nums==3
                    DNA_Code(1, i) = r(3);      %C
                else
                    DNA_Code(1, i) = r(4);      %G
                end
            else
                if nums==3
                    DNA_Code(1, i) = r(4);      %G
                else
                    DNA_Code(1, i) = r(3);      %C
                end
            end
        end
    elseif nums == 3 || nums ==4
        for i = 1: t
            if A(1, i) == 1
                DNA_Code(1, i) = r(1);          %A
            elseif A(1, i) == 2
                DNA_Code(1, i) = r(2);          %T
            elseif A(1, i) == 3
                if nums==3
                    DNA_Code(1, i) = r(3);      %C
                else
                    DNA_Code(1, i) = r(4);      %G
                end
            else
                if nums==4
                    DNA_Code(1, i) = r(4);      %G
                else
                    DNA_Code(1, i) = r(3);      %C
                end
            end
        end
    elseif nums == 5 || nums == 6
        for i = 1: t
            if A(1, i) == 2
                DNA_Code(1, i) = r(1);          %A
            elseif A(1, i) == 1
                DNA_Code(1, i) = r(2);          %T
            elseif A(1, i) == 3
                if nums==5
                    DNA_Code(1, i) = r(3);      %C
                else
                    DNA_Code(1, i) = r(4);      %G
                end
            else
                if nums==5
                    DNA_Code(1, i) = r(4);      %G
                else
                    DNA_Code(1, i) = r(3);      %C
                end
            end
        end
    elseif nums == 7 || nums == 8
        for i = 1: t
            if A(1, i) == 3
                DNA_Code(1, i) = r(1);          %A
            elseif A(1, i) == 0
                DNA_Code(1, i) = r(2);          %T
            elseif A(1, i) == 2
                if nums == 7
                    DNA_Code(1, i) = r(3);      %C
                else
                    DNA_Code(1, i) = r(4);      %G
                end
            else
                if nums==7
                    DNA_Code(1, i) = r(4);      %G
                else
                    DNA_Code(1, i) = r(3);      %C
                end
            end
        end
    end
end

