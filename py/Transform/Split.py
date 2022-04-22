import numpy as np
from Read_image import Grey, RGB


def to_8(np_matrix, mode):  # 把图像分成8*8的块
    H = np_matrix.shape[0]
    W = np_matrix.shape[1]
    H1 = int(H / 8)
    W1 = int(W / 8)
    if mode == 0:  # RGB
        R = np_matrix[:, :, 0]
        G = np_matrix[:, :, 1]
        B = np_matrix[:, :, 2]
        result = np.zeros(shape=(3, H1, W1, 8, 8), dtype=np_matrix.dtype)
        for i in range(H1):
            for j in range(W1):
                result[0][i][j] = R[i * 8:i * 8 + 8, j * 8: j * 8 + 8]
                result[1][i][j] = G[i * 8:i * 8 + 8, j * 8: j * 8 + 8]
                result[2][i][j] = B[i * 8:i * 8 + 8, j * 8: j * 8 + 8]
    else:  # Grey
        result = np.zeros(shape=(H1, W1, 8, 8), dtype=np_matrix.dtype)
        for i in range(H1):
            for j in range(W1):
                result[i][j] = np_matrix[i * 8:i * 8 + 8, j * 8: j * 8 + 8]
    return result


def to_1(np_matrix, mode):
    if mode == 0:  # RGB
        pass
    else:
        H = np_matrix.shape[0]
        W = np_matrix.shape[1]
        temp = np.zeros(shape=(H, 8, W * 8), dtype=np_matrix.dtype)
        for i in range(H):
            temp[i] = np.column_stack(np_matrix[i])
        result = np.row_stack(temp)
        return result


if __name__ == '__main__':
    path = "C://Users//ZengHW//Desktop//h//NB0001.bmp"
    a = RGB.read(path)

    b = to_8(a, 0)
    print(b[0][0])
    print(1)
