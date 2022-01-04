package M_1;

import Reading_image.Grey;

import java.util.Arrays;

public class Split {
    public static int[][][] to_8(int[][] grey) {          // gery[width][height]
        int width = grey.length;
        int height = grey[0].length;

        /*if (width % 8 != 0) {
            if (height % 8 != 0) {
                int[][] new_grey = new int[width + width % 8][height + height % 8];
                for (int i =)
            }
        }*/

        int num = width * height / 64;
        int[][][] result = new int[num][8][8];
        int count = 0, z = 0, k = 0;
        int x = 0;
        int y = 0;
        while(count < num) {
            for (int i = x * 8; i < x * 8 + 8; i++) {
                for (int j = y * 8; j < y * 8 + 8; j++) {
                    result[count][i % 8][j % 8] = grey[i][j];
                }
            }
            x++;
            count++;
            if ((x * 8 + 8) > width) {
                x = 0;
                y++;
            }

        }
        return result;


    }

    public static void main(String[] args) {
        String img_name= "C:\\Users\\ZengHW\\Desktop\\h\\lena_gray.bmp";
        int[][] a = Grey.read_grey(img_name);
        int[][][] b = to_8(a);
        System.out.println(1);
    }
}
