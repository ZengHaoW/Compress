import cv2
import numpy as np


class Grey:

    @staticmethod
    def read(image_path):
        img = cv2.imread(image_path, 0)             # reads an image in the Grey format [H, W]

        return img
    @staticmethod
    def save(image_path, matrix):
        cv2.imwrite(image_path, matrix)


if __name__ == '__main__':
    path = "C://Users//ZengHW//Desktop//h//lena_gray.bmp"
    a = Grey.read(path)


    x = np.array([[0, 1, 2, 3],
           [4, 5, 6, 7],
           [8, 9, 10, 11],
           [12, 13, 14, 15]])
    print(x)
    print()
    b = x[::2]
    print(b)
    c = b[0][::2]
    print()
    print(c)

