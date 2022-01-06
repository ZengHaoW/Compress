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

    k = l= [1, 2, 5, 6]
    i = 0
    j = 0

    for i in range(0,4,2):
        for j in range(0,4,2):
            white[i][j] = left_top(block, k[i], l[j])[1]
            green[i][j] = left_top(block, k[i], l[j])[2]
            yellow[i][j] = left_top(block, k[i], l[j])[0]

    for i in range(0,4,2):
        for j in range(1,4,2):
            white[i][j] = right_top(block, k[i], l[j])[1]
            green[i][j] = right_top(block, k[i], l[j])[2]
            yellow[i][j] = right_top(block, k[i], l[j])[0]

    for i in range(1,4,2):
        for j in range(0,4,2):
            white[i][j] = left_down(block, k[i], l[j])[1]
            green[i][j] = left_down(block, k[i], l[j])[2]
            yellow[i][j] = left_down(block, k[i], l[j])[0]

    for i in range(1,4,2):
        for j in range(1,4,2):
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
    result[1][0] = result[1][0] - result[0][0];
    result[1][1] = result[1][1] - result[0][0];
    result[0][1] = result[0][1] - result[0][0];
    return result

def stage(block):
    return stage3(stage2(stage1(block)))

def every_block(np_matrix):  # 64*64*8*8
    result = np_matrix.copy()
    for i in range(np_matrix.shape[0]):
        for j in range(np_matrix.shape[1]):
            result[i][j] = stage(np_matrix[i][j])
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
    # print(test)
    # print()
    # a = stage1(test)
    # b = stage2(a)
    # c = stage3(b)
    # print(a)
    # print()
    # print(b)
    # print()
    # print(c)

    # print(stage(test))

    path = "C://Users//ZengHW//Desktop//h//lena_gray.bmp"
    a = Grey.read(path)
    b = Split.to_8(a, 1)
    print(b)
    print()
    print(every_block(b))
