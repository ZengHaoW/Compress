import numpy as np

from Read_image import Grey
from Transform import Compute, Split


def DC(block):  # 差值计算
    temp1 = block
    temp2 = np.diff(temp1)
    temp3 = np.zeros(shape=8, dtype=block.dtype)
    temp3[0] = temp1[0][0]
    for i in range(1, 8):
        temp3[i] = temp1[i][0] - temp1[i - 1][7]
    temp4 = np.insert(temp2, 0, values=temp3, axis=1)

    return temp4


def inv_DC(block):
    result = np.zeros(shape=block.shape, dtype=block.dtype)
    H = block.shape[0]
    W = block.shape[1]
    result[0][0] = block[0][0]
    for i in range(H):
        if i > 0:
            result[i][0] = block[i][0] + result[i - 1][7]
        for j in range(1, W):
            result[i][j] = block[i][j] + result[i][j - 1]

    return result


def DC_Code(block):  # DC编码
    temp = DC(block)
    result = np.zeros(shape=block.shape, dtype='U12')

    for i in range(temp.shape[0]):
        for j in range(temp.shape[1]):
            k = abs(temp[i][j])
            if k == 0:
                result[i][j] = "00" + "0"  # 2 + 1 = 3
            elif k < 2:
                if temp[i][j] < 0:
                    result[i][j] = '{:01b}'.format(k ^ 0b1)
                else:
                    result[i][j] = '{:01b}'.format(k)
                result[i][j] = "010" + result[i][j]  # 3 + 1 = 4
            elif k < 4:
                if temp[i][j] < 0:
                    result[i][j] = '{:02b}'.format(k ^ 0b11)
                else:
                    result[i][j] = '{:02b}'.format(k)
                result[i][j] = "011" + result[i][j]  # 3 + 2 = 5
            elif k < 8:
                if temp[i][j] < 0:
                    result[i][j] = '{:03b}'.format(k ^ 0b111)
                else:
                    result[i][j] = '{:03b}'.format(k)
                result[i][j] = "100" + result[i][j]  # 3 + 3 = 6

            elif k < 16:
                if temp[i][j] < 0:
                    result[i][j] = '{:04b}'.format(k ^ 0b1111)
                else:
                    result[i][j] = '{:04b}'.format(k)
                result[i][j] = "101" + result[i][j]  # 3 + 4 = 7
            elif k < 32:
                if temp[i][j] < 0:
                    result[i][j] = '{:05b}'.format(k ^ 0b11111)
                else:
                    result[i][j] = '{:05b}'.format(k)
                result[i][j] = "110" + result[i][j]  # 3 + 5 = 8
            elif k < 64:
                if temp[i][j] < 0:
                    result[i][j] = '{:06b}'.format(k ^ 0b111111)
                else:
                    result[i][j] = '{:06b}'.format(k)
                result[i][j] = "1110" + result[i][j]  # 4 + 6 = 10
            elif k < 128:
                if temp[i][j] < 0:
                    result[i][j] = '{:07b}'.format(k ^ 0b1111111)
                else:
                    result[i][j] = '{:07b}'.format(k)
                result[i][j] = "11110" + result[i][j]  # 5 + 7 = 12
            elif k < 256:
                if temp[i][j] < 0:
                    result[i][j] = '{:08b}'.format(k ^ 0b11111111)
                else:
                    result[i][j] = '{:08b}'.format(k)
                result[i][j] = "111110" + result[i][j]  # 6 + 8 = 14
            elif k < 512:
                if temp[i][j] < 0:
                    result[i][j] = '{:09b}'.format(k ^ 0b111111111)
                else:
                    result[i][j] = '{:09b}'.format(k)
                result[i][j] = "1111110" + result[i][j]  # 7 + 9 = 16

    return result


def calculated_length(block):
    count = 0
    for i in block:
        for j in i:
            count = count + len(j)
    return count


def inv_code(block):  # DC反变换
    H = block.shape[0]
    W = block.shape[1]
    result = np.zeros(shape=block.shape, dtype=int)
    for i in range(H):
        for j in range(W):
            num = block[i][j]
            length = len(num)
            if length == 3:
                result[i][j] = 0
            elif length == 4:
                if num[3:4] == '0':
                    result[i][j] = -(int(num[3:], 2) ^ 0b1)
                else:
                    result[i][j] = int(num[3:], 2)
            elif length == 5:
                if num[3:4] == '0':
                    result[i][j] = -(int(num[3:], 2) ^ 0b11)
                else:
                    result[i][j] = int(num[3:], 2)
            elif length == 6:
                if num[3:4] == '0':
                    result[i][j] = -(int(num[3:], 2) ^ 0b111)
                else:
                    result[i][j] = int(num[3:], 2)
            elif length == 7:
                if num[3:4] == '0':
                    result[i][j] = -(int(num[3:], 2) ^ 0b1111)
                else:
                    result[i][j] = int(num[3:], 2)
            elif length == 8:
                if num[3:4] == '0':
                    result[i][j] = -(int(num[3:], 2) ^ 0b11111)
                else:
                    result[i][j] = int(num[3:], 2)
            elif length == 10:
                if num[4:5] == '0':
                    result[i][j] = -(int(num[4:], 2) ^ 0b111111)
                else:
                    result[i][j] = int(num[4:], 2)
            elif length == 12:
                if num[5:6] == '0':
                    result[i][j] = -(int(num[5:], 2) ^ 0b1111111)
                else:
                    result[i][j] = int(num[5:], 2)
            elif length == 14:
                if num[6:7] == '0':
                    result[i][j] = -(int(num[6:], 2) ^ 0b11111111)
                else:
                    result[i][j] = int(num[6:], 2)
            elif length == 16:
                if num[7:8] == '0':
                    result[i][j] = -(int(num[7:], 2) ^ 0b111111111)
                else:
                    result[i][j] = int(num[7:], 2)
    return result


def every_block(np_matrix):  # 64*64*8*8
    result = result = np.zeros(shape=np_matrix.shape, dtype='U12')
    for i in range(np_matrix.shape[0]):
        for j in range(np_matrix.shape[1]):
            result[i][j] = DC_Code(np_matrix[i][j])
    return result


def inv_every_block(np_matrix):
    result = np.zeros(shape=np_matrix.shape, dtype=int)
    for i in range(np_matrix.shape[0]):
        for j in range(np_matrix.shape[1]):
            result[i][j] = inv_DC(inv_code(np_matrix[i][j]))
    return result


if __name__ == '__main__':
    # test = np.array([[137, 135, 140, 140, 138, 140, 140, 140],
    #                  [143, 138, 139, 143, 139, 137, 140, 142],
    #                  [135, 136, 138, 139, 136, 138, 138, 141],
    #                  [138, 137, 139, 139, 138, 137, 143, 137],
    #                  [137, 138, 136, 135, 136, 138, 141, 134],
    #                  [136, 140, 137, 136, 135, 132, 138, 138],
    #                  [137, 139, 139, 136, 131, 129, 139, 138],
    #                  [138, 135, 137, 134, 138, 136, 139, 137]])
    test = np.array([[97, 1, 4, 6, 0, -3, -7, -6],
                     [-2, 1, 6, -2, 1, -3, -7, -5],
                     [0, 5, 3, 1, 1, -1, -7, 0],
                     [5, 2, -1, 0, -2, -5, -9, 1],
                     [-1, -3, -1, -5, -1, -1, -8, -1],
                     [0, 0, -7, 0, 0, -3, 1, -4],
                     [0, 2, 0, 3, 3, 1, -5, 6],
                     [-2, 1, -7, -3, -3, 2, -10, 5]
                     ])
    print("测试用例")
    print(test)
    # print("变换：")
    # print(Compute.stage(test))
    print("DC:")
    b = DC(test)
    print(b)
    print("DC编码")
    d = DC_Code(test)
    print(d)
    # print("编码后位长：")
    # print(calculated_length(DC_Code(test)))
    print("DC解码：")
    e = inv_code(d)
    print(e)
    f = inv_DC(e)
    print("jiema")
    print(f)
    print((f==test).all())
    # path = "C://Users//ZengHW//Desktop//h//lena_gray.bmp"
    # a = Grey.read(path)
    # b = Split.to_8(a, 1)
    # c = Compute.every_block(b)
    # d = every_block(c)
    # print(b[0][0])
    # print(c[0][0])
    # print(d[0][0])
    # count = 0
    # for i in d:
    #     for j in i:
    #         count = count + calculated_length(j)
    # print(count)

    # a = Compute.stage(test)
    # b = np.diff(a)
    # c = np.zeros(shape=8, dtype=a.dtype)
    # c[0] = a[0][0]
    # for i in range(1, 8):
    #     c[i] = a[i][0] - a[i - 1][7]
    # print(a)
    # print()
    # print(b)
    # print()
    # print(c)
    # print()
    # d = np.insert(b, 0, values=c, axis=1)
    # print(d)
