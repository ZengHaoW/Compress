function [result] = positionChange(matrix8)
%POSITIONCHANGE 此处显示有关此函数的摘要
    % 将矩阵分为4个4*4的块
    q = mat2cell(matrix8, [4 4], [4 4]);
    for i = 1: 2
        for j = 1:2
            a = q{i, j};
            temp = a(1:2, 3:4);
            a(1:2, 3:4) = a(3:4, 3:4);
            a(3:4, 3:4) = temp;

            temp = a(3:4, 1:2);
            a(3:4, 1:2) = a(3:4, 3:4);
            a(3:4, 3:4) = temp;

            a(1:2, 3:4) = positionChange2(a(1:2, 3:4));
            a(3:4, 1:2) = positionChange2(a(3:4, 1:2));
            a(3:4, 3:4) = positionChange2(a(3:4, 3:4));

            q{i, j} = a;

        end
    end
    result = cell2mat(q);
    
    
    
    
end

function [matrix4] = positionChange2(matrix4)
        temp2 = matrix4(1, 2);
        matrix4(1, 2) = matrix4(2, 2);
        matrix4(2, 2) = temp2;

        temp2 = matrix4(2, 2);
        matrix4(2, 2) = matrix4(2, 1);
        matrix4(2, 1) = temp2;
end

