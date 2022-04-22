import cv2
import numpy as np


def read(image_path):
    img = cv2.imread(image_path)  # reads an image in the BGR format        [H,W,3]
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)  # BGR -> RGB
    return np.array(img, dtype=np.int)

def save(image_path, matrix):
    matrix = cv2.cvtColor(matrix, cv2.COLOR_RGB2BGR)
    cv2.imwrite(image_path, matrix)


if __name__ == '__main__':
    path = "C://Users//ZengHW//Desktop//h//NB0001.bmp"
    a = read(path)
    print(a[1][511])



