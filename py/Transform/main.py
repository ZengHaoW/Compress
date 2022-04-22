import numpy as np

from Read_image import Grey, RGB
from Transform import Split, Compute, Code


def transform(path, mode):
    if mode == 1:
        pixel_matrix = Grey.read(path)
        raw_bits = pixel_matrix.shape[0] * pixel_matrix.shape[1] * 8
        divide_to_8 = Split.to_8(pixel_matrix, mode)
        trans = Compute.every_block(divide_to_8, mode)
        coding = Code.every_block(trans, mode)
        compress_bits = Code.calulated_all(coding, mode)
        cr = raw_bits / compress_bits

        print("raw bits: " + str(raw_bits))
        print("compress bits: " + str(compress_bits))
        print("compression ratio: " + str(round(cr, 4)))
    else:
        pixel_matrix = RGB.read(path)
        raw_bits = pixel_matrix.shape[0] * pixel_matrix.shape[1] * pixel_matrix.shape[2] * 8
        divide_to_8 = Split.to_8(pixel_matrix, mode)
        trans = Compute.every_block(divide_to_8, mode)
        coding = Code.every_block(trans, mode)
        compress_bits = Code.calulated_all(coding, mode)
        cr = raw_bits / compress_bits
        print("raw bits: " + str(raw_bits))
        print("compress bits: " + str(compress_bits))
        print("compression ratio: " + str(round(cr, 4)))


if __name__ == '__main__':
    r = 0
    g = 1
    n = g
    path = "C://Users//ZengHW//Desktop//test image//32.tiff"
    transform(path, n)
    # n = g
    #
    # a = Grey.read(path)
    # b = Split.to_8(a, n)
    # c = Compute.every_block(b, n)
    # d = Code.every_block(c, n)
    #
    #
    # print(Code.calulated_all(d, n))
    # k = 0
    # e = Code.inv_every_block(d)
    # f = Compute.inv_every_block(c)
    # g = Split.to_1(f,1)
    # for i in range(64):
    #     for j in range(64):
    #         if (e[i][j] == c[i][j]).all():
    #             pass
    #         else:
    #             print(k)
    #             k = k + 1
    # print((f == b).all())
    # print((g == a).all())
    # Grey.save("C://Users//ZengHW//Desktop//h//lena_gray_new.bmp", g)
