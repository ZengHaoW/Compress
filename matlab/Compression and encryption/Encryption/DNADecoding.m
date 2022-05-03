function [pixel] = DNADecoding(DNA_Code, nums)
%DNADECODING 根据nums将DNA_Code解码
%   DNA_Code(1, 5)   pixel(1, 1)
    r = ['A' 'T' 'C' 'G'];
    temp = ones(1, 5);  %存放解码后的位数，从高到底 
    for i = 1: 5
        if DNA_Code(i) == r(1)          % A
            if nums == 1 || nums == 2
                temp(i) = 0;
            elseif nums == 3 || nums == 4
                temp(i) = 1;
            elseif nums == 5 || nums == 6
                temp(i) = 2;
            elseif nums == 7 || nums == 8
                temp(i) = 3;
            end
        elseif DNA_Code(i) == r(2)      % T
            if nums == 1 || nums == 2
                temp(i) = 3;
            elseif nums == 3 || nums == 4
                temp(i) = 2;
            elseif nums == 5 || nums == 6
                temp(i) = 1;
            elseif nums == 7 || nums == 8
                temp(i) = 0;
            end
        elseif DNA_Code(i) == r(3)      % C
            if nums == 1 || nums == 7
                temp(i) = 2;
            elseif nums == 2 || nums == 8
                temp(i) = 1;
            elseif nums == 3 || nums == 5
                temp(i) = 3;
            elseif nums == 4 || nums == 6
                temp(i) = 0;
            end
        elseif DNA_Code(i) == r(4)      % G
            if nums == 1 || nums == 7
                temp(i) = 1;
            elseif nums == 2 || nums == 8
                temp(i) = 2;
            elseif nums == 3 || nums == 5
                temp(i) = 0;
            elseif nums == 4 || nums == 6
                temp(i) = 3;
            end
        end
    end
    pixel = bitshift(temp(1), 8) + bitshift(temp(2), 6) + bitshift(temp(3), 4) + bitshift(temp(4), 2) + temp(5);
end

