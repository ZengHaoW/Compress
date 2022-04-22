import numpy as np

from Read_image import Grey
from Transform import Split


def left_top(block, i, j):
    result = np.array([[block[i - 1][j] - block[i][j]],  # yellow
                       [block[i - 1][j - 1] - block[i][j]],  # white
                       [block[i][j - 1] - block[i][j]]])  # green
    return result


def left_down(block, i, j):
    result = np.array([[block[i][j - 1] - block[i][j]],  # yellow
                       [block[i + 1][j - 1] - block[i][j]],  # white
                       [block[i + 1][j] - block[i][j]]])  # green
    return result


def right_top(block, i, j):
    result = np.array([[block[i][j + 1] - block[i][j]],  # yellow
                       [block[i - 1][j + 1] - block[i][j]],  # white
                       [block[i - 1][j] - block[i][j]]])  # green
    return result


def right_down(block, i, j):
    result = np.array([[block[i + 1][j] - block[i][j]],  # yellow
                       [block[i + 1][j + 1] - block[i][j]],  # white
                       [block[i][j + 1] - block[i][j]]])  # green
    return result


def stage1(block):  # H, W
    result = np.zeros(shape=(8, 8), dtype=block.dtype)
    green = np.zeros(shape=(4, 4), dtype=block.dtype)
    yellow = np.zeros(shape=(4, 4), dtype=block.dtype)
    white = np.zeros(shape=(4, 4), dtype=block.dtype)

    k = l = [1, 2, 5, 6]
    i = 0
    j = 0

    for i in range(0, 4, 2):
        for j in range(0, 4, 2):
            white[i][j] = left_top(block, k[i], l[j])[1]
            green[i][j] = left_top(block, k[i], l[j])[2]
            yellow[i][j] = left_top(block, k[i], l[j])[0]

    for i in range(0, 4, 2):
        for j in range(1, 4, 2):
            white[i][j] = right_top(block, k[i], l[j])[1]
            green[i][j] = right_top(block, k[i], l[j])[2]
            yellow[i][j] = right_top(block, k[i], l[j])[0]

    for i in range(1, 4, 2):
        for j in range(0, 4, 2):
            white[i][j] = left_down(block, k[i], l[j])[1]
            green[i][j] = left_down(block, k[i], l[j])[2]
            yellow[i][j] = left_down(block, k[i], l[j])[0]

    for i in range(1, 4, 2):
        for j in range(1, 4, 2):
            white[i][j] = right_down(block, k[i], l[j])[1]
            green[i][j] = right_down(block, k[i], l[j])[2]
            yellow[i][j] = right_down(block, k[i], l[j])[0]

    for i in range(4):
        for j in range(4):
            result[i][j] = block[k[i]][k[j]]
            result[i][j + 4] = white[i][j]
            result[i + 4][j] = yellow[i][j]
            result[i + 4][j + 4] = green[i][j]
    return result


def stage2(block):
    result = block.copy()
    green = np.zeros(shape=(2, 2), dtype=block.dtype)
    yellow = np.zeros(shape=(2, 2), dtype=block.dtype)
    white = np.zeros(shape=(2, 2), dtype=block.dtype)

    k = l = [1, 2]
    i = 0
    j = 0

    white[i][j] = left_top(block, k[i], l[j])[1]
    green[i][j] = left_top(block, k[i], l[j])[2]
    yellow[i][j] = left_top(block, k[i], l[j])[0]
    j = 1

    white[i][j] = right_top(block, k[i], l[j])[1]
    green[i][j] = right_top(block, k[i], l[j])[2]
    yellow[i][j] = right_top(block, k[i], l[j])[0]

    i = 1

    white[i][j] = right_down(block, k[i], l[j])[1]
    green[i][j] = right_down(block, k[i], l[j])[2]
    yellow[i][j] = right_down(block, k[i], l[j])[0]

    j = 0
    white[i][j] = left_down(block, k[i], l[j])[1]
    green[i][j] = left_down(block, k[i], l[j])[2]
    yellow[i][j] = left_down(block, k[i], l[j])[0]

    for i in range(2):
        for j in range(2):
            result[i][j] = block[k[i]][k[j]]
            result[i][j + 2] = white[i][j]
            result[i + 2][j] = yellow[i][j]
            result[i + 2][j + 2] = green[i][j]
    return result


def stage3(block):
    result = block.copy()
    result[1][0] = result[1][0] - result[0][0]
    result[1][1] = result[1][1] - result[0][0]
    result[0][1] = result[0][1] - result[0][0]
    return result


def stage3_inv(block):
    result = block.copy()
    result[1][0] = result[1][0] + result[0][0]
    result[1][1] = result[1][1] + result[0][0]
    result[0][1] = result[0][1] + result[0][0]
    return result


def stage2_inv(block):
    result = block.copy()

    temp = set_4block(block[0:4, 0:4])
    for i in range(4):
        for j in range(4):
            result[i][j] = temp[i][j]
    result[1][1] = block[0][0]
    result[1][2] = block[0][1]
    result[2][1] = block[1][0]
    result[2][2] = block[1][1]

    add_4block(result[0:4, 0:4])
    return result


def stage1_inv(block):
    result = block.copy()
    temp = np.zeros(shape=(4,4,4), dtype=block.dtype)

    temp[0] = np.vstack((np.hstack((block[0:2, 0:2], block[0:2, 4:6])),
                         np.hstack((block[4:6, 0:2], block[4:6, 4:6]))))

    temp[1] = np.vstack((np.hstack((block[0:2, 2:4], block[0:2, 6:8])),
                         np.hstack((block[4:6, 2:4], block[4:6, 6:8]))))

    temp[2] = np.vstack((np.hstack((block[2:4, 0:2], block[2:4, 4:6])),
                         np.hstack((block[6:8, 0:2], block[6:8, 4:6]))))

    temp[3] = np.vstack((np.hstack((block[2:4, 2:4], block[2:4, 6:8])),
                         np.hstack((block[6:8, 2:4], block[6:8, 6:8]))))
    temp_1 = set_4block(temp[0])
    for i in range(4):
        for j in range(4):
            result[i][j] = temp_1[i][j]
    result[1][1] = temp[0][0][0]
    result[1][2] = temp[0][0][1]
    result[2][1] = temp[0][1][0]
    result[2][2] = temp[0][1][1]
    add_4block(result[0:4, 0:4])

    temp_2 = set_4block(temp[1])
    for i in range(4):
        for j in range(4):
            result[i][j+4] = temp_2[i][j]
    result[1][1+4] = temp[1][0][0]
    result[1][2+4] = temp[1][0][1]
    result[2][1+4] = temp[1][1][0]
    result[2][2+4] = temp[1][1][1]
    add_4block(result[0:4, 4:8])

    temp_3 = set_4block(temp[2])
    for i in range(4):
        for j in range(4):
            result[i+4][j] = temp_3[i][j]
    result[1+4][1] = temp[2][0][0]
    result[1+4][2] = temp[2][0][1]
    result[2+4][1] = temp[2][1][0]
    result[2+4][2] = temp[2][1][1]
    add_4block(result[4:8, 0:4])

    temp_4 = set_4block(temp[3])
    for i in range(4):
        for j in range(4):
            result[i+4][j+4] = temp_4[i][j]
    result[1+4][1+4] = temp[3][0][0]
    result[1+4][2+4] = temp[3][0][1]
    result[2+4][1+4] = temp[3][1][0]
    result[2+4][2+4] = temp[3][1][1]
    add_4block(result[4:8, 4:8])
    return result



def get_white(block_4):
    white = np.zeros(shape=(2, 2), dtype=block_4.dtype)
    for i in range(2):
        for j in range(2):
            white[i][j] = block_4[i][j + 2]
    return white


def get_yellow(block_4):
    yellow = np.zeros(shape=(2, 2), dtype=block_4.dtype)
    for i in range(2):
        for j in range(2):
            yellow[i][j] = block_4[i + 2][j]
    return yellow


def get_green(block_4):
    green = np.zeros(shape=(2, 2), dtype=block_4.dtype)
    for i in range(2):
        for j in range(2):
            green[i][j] = block_4[i + 2][j + 2]
    return green


def set_4block(block_4):
    white = get_white(block_4)
    green = get_green(block_4)
    yellow = get_yellow(block_4)
    result = block_4.copy()

    result[0][0] = white[0][0]
    result[0][3] = white[0][1]
    result[3][0] = white[1][0]
    result[3][3] = white[1][1]

    result[0][1] = yellow[0][0]
    result[1][3] = yellow[0][1]
    result[2][0] = yellow[1][0]
    result[3][2] = yellow[1][1]

    result[1][0] = green[0][0]
    result[0][2] = green[0][1]
    result[3][1] = green[1][0]
    result[2][3] = green[1][1]

    return result


def add_4block(block_4):
    block_4[0][0] = block_4[0][0] + block_4[1][1]
    block_4[0][1] = block_4[0][1] + block_4[1][1]
    block_4[1][0] = block_4[1][0] + block_4[1][1]

    block_4[0][2] = block_4[0][2] + block_4[1][2]
    block_4[0][3] = block_4[0][3] + block_4[1][2]
    block_4[1][3] = block_4[1][3] + block_4[1][2]

    block_4[2][0] = block_4[2][0] + block_4[2][1]
    block_4[3][0] = block_4[3][0] + block_4[2][1]
    block_4[3][1] = block_4[3][1] + block_4[2][1]

    block_4[3][2] = block_4[3][2] + block_4[2][2]
    block_4[2][3] = block_4[2][3] + block_4[2][2]
    block_4[3][3] = block_4[3][3] + block_4[2][2]


def stage(block):
    return stage3(stage2(stage1(block)))
def inv_stage(block):
    return stage1_inv(stage2_inv(stage3_inv(block)))

def every_block(np_matrix, mode):  # 64*64*8*8   mode=1 :GREY  mode=0 :RGB
    result = np_matrix.copy()
    if mode == 1:
        for i in range(np_matrix.shape[0]):
            for j in range(np_matrix.shape[1]):
                result[i][j] = stage(np_matrix[i][j])
    else:
        for k in range(3):
            for i in range(np_matrix.shape[1]):
                for j in range(np_matrix.shape[2]):
                    result[k][i][j] = stage(np_matrix[k][i][j])
    return result
def inv_every_block(np_matrix):  # 64*64*8*8
    result = np_matrix.copy()
    for i in range(np_matrix.shape[0]):
        for j in range(np_matrix.shape[1]):
            result[i][j] = inv_stage(np_matrix[i][j])
    return result


if __name__ == '__main__':
    test = np.array([[137, 135, 140, 140, 138, 140, 140, 140],
                     [143, 138, 139, 143, 139, 137, 140, 142],
                     [135, 136, 138, 139, 136, 138, 138, 141],
                     [138, 137, 139, 139, 138, 137, 143, 137],
                     [137, 138, 136, 135, 136, 138, 141, 134],
                     [136, 140, 137, 136, 135, 132, 138, 138],
                     [137, 139, 139, 136, 131, 129, 139, 138],
                     [138, 135, 137, 134, 138, 136, 139, 137]])
    print(test)
    print()
    a = stage1(test)
    print(a)
    print()
    b = stage2(a)
    print(b)
    print()
    c = stage3(b)
    print(c)
    print()
    d = stage3_inv(c)
    print(d)
    print()
    e = stage2_inv(d)
    print(e)
    print()
    f = inv_stage(c)
    print(f)
    print((test==f).all())



    # print(stage(test))

    # path = "C://Users//ZengHW//Desktop//h//lena_gray.bmp"
    # a = Grey.read(path)
    # b = Split.to_8(a, 1)
    # print(b)
    # print()
    # print(every_block(b))
