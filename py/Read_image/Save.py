import cv2
import numpy as np
from Read_image.Grey import Grey

# x is the array you want to save
from Read_image.RGB import RGB


class Save:

    @staticmethod
    def save(matrix, img_name):
        cv2.imwrite(img_name, matrix)

if __name__ == '__main__':
    path = "C://Users//ZengHW//Desktop//h//NB0001.bmp"
    a = RGB.read(path)

    b = a[0::8, 0::8, 0::1]
    cv2.imwrite("C://Users//ZengHW//Desktop//h//lena_gray1.bmp", cv2.cvtColor(b, cv2.COLOR_RGB2BGR))
    # path1 = "C://Users//ZengHW//Desktop//h//lena_gray1.bmp"
    # a1 = Grey.read(path)

    print(1)

