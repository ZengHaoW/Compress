import cv2
import numpy as np



def read(image_path):
    img = cv2.imread(image_path, 0)             # reads an image in the Grey format [H, W]

    return np.array(img, dtype=np.int)

def save(image_path, matrix):
    cv2.imwrite(image_path, matrix)


if __name__ == '__main__':
    path = "C://Users//ZengHW//Desktop//test image//4.1.01.tiff"
    a = read(path)
    a = np.array(a, dtype=np.int)
    print(a)

    save("C://Users//ZengHW//Desktop//h//lena_gray123.bmp", a)

    # x = np.array([[0, 1, 2, 3],
    #        [4, 5, 6, 7],
    #        [8, 9, 10, 11],
    #        [12, 13, 14, 15]])
    # print(x)
    # print()
    # b = x[::2]
    # print(b)
    # c = b[0][::2]
    # print()
    # print(c)

