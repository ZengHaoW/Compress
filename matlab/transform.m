function [result, pixelDontChange] = transform(Block)
%TRANSFORM 对每个8*8的块进行变换
%   此处显示详细说明
    result = stage3(stage2(stage1(Block)));
    pixelDontChange = result(1, 1);
%     result(1, 1) = 0;
end

function [result] = stage1(Block_8)
% 变换阶段一
    result = ones(8, 8);
    greenMatrix = ones(4, 4);
    whiteMatrix = ones(4, 4);
    yellowMatrix = ones(4, 4);
    k = [2, 3, 6, 7];
    %%
    for i = 1: 2: 4
        for j = 1: 2: 4
            [yellow, white, green] = leftTop(Block_8, k(i), k(j));
            greenMatrix(i, j) = green;
            whiteMatrix(i, j) = white;
            yellowMatrix(i, j) = yellow;
        end
    end
    %%
    for i = 1:2:4
        for j = 2: 2: 4
            [yellow, white, green] = rightTop(Block_8, k(i), k(j));
            greenMatrix(i, j) = green;
            whiteMatrix(i, j) = white;
            yellowMatrix(i, j) = yellow;
        end
    end
    %%
    for i = 2: 2: 4
        for j = 1: 2: 4
            [yellow, white, green] = leftDown(Block_8, k(i), k(j));
            greenMatrix(i, j) = green;
            whiteMatrix(i, j) = white;
            yellowMatrix(i, j) = yellow;
        end
    end
    %%
    for i = 2: 2: 4
        for j = 2: 2: 4
            [yellow, white, green] = rightDown(Block_8, k(i), k(j));
            greenMatrix(i, j) = green;
            whiteMatrix(i, j) = white;
            yellowMatrix(i, j) = yellow;
        end
    end
    %%
    for i = 1: 1: 4
        for j = 1: 1: 4
            result(i, j) = Block_8(k(i), k(j));
            result(i, j + 4) = whiteMatrix(i, j);
            result(i + 4, j) = yellowMatrix(i, j);
            result(i + 4, j + 4) = greenMatrix(i, j);
        end
    end
end

function [result] = stage2(stage1Block)
    result = stage1Block;
    greenMatrix = ones(2, 2);
    whiteMatrix = ones(2, 2);
    yellowMatrix = ones(2, 2);
    k = [2, 3];
    %%
    i = 1; j = 1;
    [yellow, white, green] = leftTop(stage1Block, k(i), k(j));
    greenMatrix(i, j) = green;
    whiteMatrix(i, j) = white;
    yellowMatrix(i, j) = yellow;
    %%
    i = 1; j = 2;
    [yellow, white, green] = rightTop(stage1Block, k(i), k(j));
    greenMatrix(i, j) = green;
    whiteMatrix(i, j) = white;
    yellowMatrix(i, j) = yellow;
    %%
    i = 2; j = 2;
    [yellow, white, green] = rightDown(stage1Block, k(i), k(j));
    greenMatrix(i, j) = green;
    whiteMatrix(i, j) = white;
    yellowMatrix(i, j) = yellow;
    %%
    i = 2; j = 1;
    [yellow, white, green] = leftDown(stage1Block, k(i), k(j));
    greenMatrix(i, j) = green;
    whiteMatrix(i, j) = white;
    yellowMatrix(i, j) = yellow;
    %% 
    for i = 1: 1: 2
        for j = 1: 1: 2
            result(i, j) = stage1Block(k(i), k(j));
            result(i, j + 2) = whiteMatrix(i, j);
            result(i + 2, j) = yellowMatrix(i, j);
            result(i + 2, j + 2) = greenMatrix(i, j);
        end
    end
end

function [result] = stage3(stage2Block)
    result = stage2Block;
    result(2, 1) = result(2, 1) - result(1, 1);
    result(2, 2) = result(2, 2) - result(1, 1);
    result(1, 2) = result(1, 2) - result(1, 1);
end
%% 将三个颜色的位置进行交换
function [yellow, white, green] = leftTop(block, i, j)
    yellow = block(i - 1, j) - block(i, j);
    white = block(i - 1, j - 1) - block(i, j);
    green = block(i, j - 1) - block(i, j);
end

function [yellow, white, green] = leftDown(block, i, j)
    yellow = block(i, j - 1) - block(i, j);
    white = block(i + 1, j - 1) - block(i, j);
    green = block(i + 1, j) - block(i, j);
end

function [yellow, white, green] = rightTop(block, i, j)
    yellow = block(i, j + 1) - block(i, j);
    white = block(i - 1, j + 1) - block(i, j);
    green = block(i - 1, j) - block(i, j);
end

function [yellow, white, green] = rightDown(block, i, j)
    yellow = block(i + 1, j) - block(i, j);
    white = block(i + 1, j + 1) - block(i, j);
    green = block(i, j + 1) - block(i, j);
end