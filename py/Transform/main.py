import numpy as np

from Read_image import Grey
from Transform import Split, Compute, Code

if __name__ == '__main__':
    path = "C://Users//ZengHW//Desktop//h//lena_gray.bmp"
    a = Grey.read(path)
    b = Split.to_8(a, 1)
    c = Compute.every_block(b)
    d = Code.every_block(c)
    print(d)
    count = 0
    for i in d:
        for j in i:
            count = count + Code.calculated_length(j)
    print(count)
    k = 0
    e = Code.inv_every_block(d)
    f = Compute.inv_every_block(e)
    for i in range(64):
        for j in range(64):
            if (e[i][j] == c[i][j]).all():
                pass
            else:
                print(k)
                k = k + 1
    print((f==b).all())




