import numpy as np

from Read_image import Grey
from Transform import Compute, Split


def DC(block):
    temp1 = Compute.stage(block)
    temp2 = np.diff(temp1)
    temp3 = np.zeros(shape=8, dtype=block.dtype)
    temp3[0] = temp1[0][0]
    for i in range(1, 8):
        temp3[i] = temp1[i][0] - temp1[i - 1][7]
    temp4 = np.insert(temp2, 0, values=temp3, axis=1)

    return temp4


def DC_Code(block):
    temp = DC(block)
    result = np.zeros(shape=block.shape, dtype='U12')

    for i in range(temp.shape[0]):
        for j in range(temp.shape[1]):
            k = abs(temp[i][j])
            if k == 0:
                result[i][j] = "000" + "0"
            elif k < 2:
                if temp[i][j] < 0:
                    result[i][j] = '{:01b}'.format(k ^ 0b1)
                else:
                    result[i][j] = '{:01b}'.format(k)
                result[i][j] = "001" + result[i][j]
            elif k < 4:
                if temp[i][j] < 0:
                    result[i][j] = '{:02b}'.format(k ^ 0b11)
                else:
                    result[i][j] = '{:02b}'.format(k)
                result[i][j] = "010" + result[i][j]
            elif k < 8:
                if temp[i][j] < 0:
                    result[i][j] = '{:03b}'.format(k ^ 0b111)
                else:
                    result[i][j] = '{:03b}'.format(k)
                result[i][j] = "011" + result[i][j]

            elif k < 16:
                if temp[i][j] < 0:
                    result[i][j] = '{:04b}'.format(k ^ 0b1111)
                else:
                    result[i][j] = '{:04b}'.format(k)
                result[i][j] = "100" + result[i][j]
            elif k < 32:
                if temp[i][j] < 0:
                    result[i][j] = '{:05b}'.format(k ^ 0b11111)
                else:
                    result[i][j] = '{:05b}'.format(k)
                result[i][j] = "101" + result[i][j]
            elif k < 64:
                if temp[i][j] < 0:
                    result[i][j] = '{:06b}'.format(k ^ 0b111111)
                else:
                    result[i][j] = '{:06b}'.format(k)
                result[i][j] = "110" + result[i][j]
            elif k < 128:
                if temp[i][j] < 0:
                    result[i][j] = '{:07b}'.format(k ^ 0b1111111)
                else:
                    result[i][j] = '{:07b}'.format(k)
                result[i][j] = "1110" + result[i][j]
            elif k < 256:
                if temp[i][j] < 0:
                    result[i][j] = '{:08b}'.format(k ^ 0b11111111)
                else:
                    result[i][j] = '{:08b}'.format(k)
                result[i][j] = "1111" + result[i][j]
    return result


def calculated_length(block):
    count = 0
    for i in block:
        for j in i:
            count = count + len(j)
    return count

def every_block(np_matrix):         # 64*64*8*8
    result = result = np.zeros(shape=np_matrix.shape, dtype='U12')
    for i in range(np_matrix.shape[0]):
        for j in range(np_matrix.shape[1]):
            result[i][j] = DC_Code(np_matrix[i][j])
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
    # b = DC(test)
    # print(b)
    # print()
    # for num in b:
    #     for i in num:
    #         i = bin(i)
    # print(b)
    path = "C://Users//ZengHW//Desktop//h//lena_gray.bmp"
    a = Grey.read(path)
    b = Split.to_8(a, 1)
    c = Compute.every_block(b)
    d = every_block(c)
    print(d)
    count = 0
    for i in d:
        for j in i:
            count = count + calculated_length(j)
    print(count)
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
