function [result] = transformInv2(Block)
%TRANSFORM 对每个8*8的块进行变换
%   此处显示详细说明
%     Block(1,1) = pixelDontChange;
    temp = Block(1:2, 1: 2);
    for i = 1: 8
        for j = 1: 8
            Block(i, j) = mod(Block(i, j), 256);
        end
    end
    Block(1:2, 1: 2) = temp;
    result = stage3Inv(stage2Inv(stage1Inv(Block)));
    
    for i = 1: 8
        for j = 1: 8
            result(i, j) = mod(result(i, j), 256);
        end
    end
end

function [result] = stage1Inv(Block)
%% 逆变换阶段一
    result = Block;
    result(2, 1) = result(2, 1) + result(1, 1);
    result(2, 2) = result(2, 2) + result(1, 1);
    result(1, 2) = result(1, 2) + result(1, 1);
end

function [result] = stage2Inv(stage3InvBlock)
%% 逆变换阶段二
    result = stage3InvBlock;
    temp = set_4Block(result(1: 4, 1: 4));
    for i = 1: 4
        for j = 1: 4
            result(i, j) = temp(i, j);
        end
    end
    result(2, 2) = stage3InvBlock(1, 1);
    result(2, 3) = stage3InvBlock(1, 2);
    result(3, 2) = stage3InvBlock(2, 1);
    result(3, 3) = stage3InvBlock(2, 2);
    result(1: 4, 1: 4) = add_4Block(result(1: 4, 1: 4));
end
function [result] = stage3Inv(block)
%% 逆变换阶段三
    result = block;
    %%
    temp_a = [[block(1:2, 1:2), block(1:2, 5:6)];[block(5:6, 1:2), block(5:6, 5:6)]];
    temp_b = [[block(1:2, 3:4), block(1:2, 7:8)];[block(5:6, 3:4), block(5:6, 7:8)]];
    temp_c = [[block(3:4, 1:2), block(3:4, 5:6)];[block(7:8, 1:2), block(7:8, 5:6)]];
    temp_d = [[block(3:4, 3:4), block(3:4, 7:8)];[block(7:8, 3:4), block(7:8, 7:8)]];
    %%
    temp_1 = set_4Block(temp_a);
    for i = 1: 4
        for j = 1: 4
            result(i, j) = temp_1(i, j);
        end
    end
    result(2,2) = temp_a(1, 1);
    result(2,3) = temp_a(1, 2);
    result(3,2) = temp_a(2, 1);
    result(3,3) = temp_a(2, 2);
    result(1:4, 1:4) = add_4Block(result(1:4, 1:4));
    %%
    temp_2 = set_4Block(temp_b);
    for i = 1: 4
        for j = 1: 4
            result(i, j+4) = temp_2(i, j);
        end
    end
    result(2,2+4) = temp_b(1, 1);
    result(2,3+4) = temp_b(1, 2);
    result(3,2+4) = temp_b(2, 1);
    result(3,3+4) = temp_b(2, 2);
    result(1:4, 5:8) = add_4Block(result(1:4, 5:8));
    %%
    temp_3 = set_4Block(temp_c);
    for i = 1: 4
        for j = 1: 4
            result(i+4, j) = temp_3(i, j);
        end
    end
    result(2+4,2) = temp_c(1, 1);
    result(2+4,3) = temp_c(1, 2);
    result(3+4,2) = temp_c(2, 1);
    result(3+4,3) = temp_c(2, 2);
    result(5:8, 1:4) = add_4Block(result(5:8, 1:4));
    %%
    temp_4 = set_4Block(temp_d);
    for i = 1: 4
        for j = 1: 4
            result(i+4, j+4) = temp_4(i, j);
        end
    end
    result(2+4,2+4) = temp_d(1, 1);
    result(2+4,3+4) = temp_d(1, 2);
    result(3+4,2+4) = temp_d(2, 1);
    result(3+4,3+4) = temp_d(2, 2);
    result(5:8, 5:8) = add_4Block(result(5:8, 5:8));
    %%
end


%% 中间步骤
function [block_4] = add_4Block(block_4)
    block_4(1, 1) = block_4(1, 1) + block_4(2, 2);
    block_4(1, 2) = block_4(1, 2) + block_4(2, 2);
    block_4(2, 1) = block_4(2, 1) + block_4(2, 2);

    block_4(1, 3) = block_4(1, 3) + block_4(2, 3);
    block_4(1, 4) = block_4(1, 4) + block_4(2, 3);
    block_4(2, 4) = block_4(2, 4) + block_4(2, 3);

    block_4(3, 1) = block_4(3, 1) + block_4(3, 2);
    block_4(4, 1) = block_4(4, 1) + block_4(3, 2);
    block_4(4, 2) = block_4(4, 2) + block_4(3, 2);

    block_4(4, 3) = block_4(4, 3) + block_4(3, 3);
    block_4(3, 4) = block_4(3, 4) + block_4(3, 3);
    block_4(4, 4) = block_4(4, 4) + block_4(3, 3);
end
function [result] = set_4Block(Block)
    white = getWhite(Block);
    green = getGreen(Block);
    yellow = getYellow(Block);
    result = Block;

    result(1, 1) = white(1, 1);
    result(1, 4) = white(1, 2);
    result(4, 1) = white(2, 1);
    result(4, 4) = white(2, 2);

    result(1, 2) = yellow(1, 1);
    result(2, 4) = yellow(1, 2);
    result(3, 1) = yellow(2, 1);
    result(4, 3) = yellow(2, 2);

    result(2, 1) = green(1, 1);
    result(1, 3) = green(1, 2);
    result(4, 2) = green(2, 1);
    result(3, 4) = green(2, 2);
end
%% 
function [white] = getWhite(Block_4)
    white = ones(2, 2);
    for i = 1: 2
        for j = 1: 2
            white(i, j) = Block_4(i, j + 2);
        end
    end
end
function [yellow] = getYellow(Block_4)
    yellow = ones(2, 2);
    for i = 1: 2
        for j = 1: 2
            yellow(i, j) = Block_4(i + 2, j);
        end
    end
end
function [green] = getGreen(Block_4)
    green = ones(2, 2);
    for i = 1: 2
        for j = 1: 2
            green(i, j) = Block_4(i + 2, j + 2);
        end
    end
end
%%