package M_1;

import Reading_image.Grey;

public class Compute {

    public static int[][] stage_1(int[][] img_matrix) {  //8 * 8
        int[][] result= new int[8][8];
        int[][] green = new int[4][4];
        int[][] yellow = new int[4][4];
        int[][] white = new int[4][4];


        int i = 0, j = 0;
        int[] z = {1, 2, 5, 6};

        while(i < 4) {
            white[i][j++] = left_top(img_matrix, z[i], 1)[1];
            white[i][j++] = left_down(img_matrix, z[i],2)[1];
            white[i][j++] = left_top(img_matrix, z[i], 5)[1];
            white[i][j++] = left_down(img_matrix, z[i], 6)[1];
            j = 0;
            green[i][j++] = left_top(img_matrix, z[i], 1)[2];
            green[i][j++] = left_down(img_matrix, z[i], 2)[2];
            green[i][j++] = left_top(img_matrix, z[i],5)[2];
            green[i][j++] = left_down(img_matrix, z[i], 6)[2];
            j = 0;
            yellow[i][j++] = left_top(img_matrix, z[i], 1)[0];
            yellow[i][j++] = left_down(img_matrix, z[i], 2)[0];
            yellow[i][j++] = left_top(img_matrix, z[i], 5)[0];
            yellow[i][j++] = left_down(img_matrix, z[i], 6)[0];
            j = 0;
            i = i + 2;
        }
        i = 1;
        while(i < 4) {
            white[i][j++] = right_top(img_matrix, z[i], 1)[1];
            white[i][j++] = right_down(img_matrix, z[i],2)[1];
            white[i][j++] = right_top(img_matrix, z[i], 5)[1];
            white[i][j++] = right_down(img_matrix, z[i], 6)[1];
            j = 0;
            green[i][j++] = right_top(img_matrix, z[i], 1)[2];
            green[i][j++] = right_down(img_matrix, z[i], 2)[2];
            green[i][j++] = right_top(img_matrix, z[i],5)[2];
            green[i][j++] = right_down(img_matrix, z[i], 6)[2];
            j = 0;
            yellow[i][j++] = right_top(img_matrix, z[i], 1)[0];
            yellow[i][j++] = right_down(img_matrix, z[i], 2)[0];
            yellow[i][j++] = right_top(img_matrix, z[i], 5)[0];
            yellow[i][j++] = right_down(img_matrix, z[i], 6)[0];
            j = 0;
            i = i + 2;
        }
        for (i = 0; i < 4; i++) {
            for (j = 0; j < 4; j++) {
                result[i][j] = img_matrix[z[i]][z[j]];
                result[i + 4][j] = white[i][j];
                result[i][j + 4] = yellow[i][j];
                result[i + 4][j + 4] = green[i][j];
            }
        }

        return result;

    }
    public static int[][] stage_2(int[][] img_matrix) {
        int[][] result = new int[8][8];
        for (int q = 0; q < 8; q++) {
            for (int w = 0; w < 8; w++)
                result[q][w] = img_matrix[q][w];
        }
        int[][] green = new int[2][2];
        int[][] yellow = new int[2][2];
        int[][] white = new int[2][2];


        int i = 0, j = 0;
        int[] z = {1, 2};

        while(true) {
            white[i][j++] = left_top(img_matrix, z[i], 1)[1];
            white[i][j++] = left_down(img_matrix, z[i],2)[1];

            j = 0;
            green[i][j++] = left_top(img_matrix, z[i], 1)[2];
            green[i][j++] = left_down(img_matrix, z[i], 2)[2];

            j = 0;
            yellow[i][j++] = left_top(img_matrix, z[i], 1)[0];
            yellow[i][j++] = left_down(img_matrix, z[i], 2)[0];

            j = 0;
            break;
        }
        i = 1;
        while(true) {
            white[i][j++] = right_top(img_matrix, z[i], 1)[1];
            white[i][j++] = right_down(img_matrix, z[i],2)[1];

            j = 0;
            green[i][j++] = right_top(img_matrix, z[i], 1)[2];
            green[i][j++] = right_down(img_matrix, z[i], 2)[2];

            j = 0;
            yellow[i][j++] = right_top(img_matrix, z[i], 1)[0];
            yellow[i][j++] = right_down(img_matrix, z[i], 2)[0];

            break;
        }
        for (i = 0; i < 2; i++) {
            for (j = 0; j < 2; j++) {
                result[i][j] = img_matrix[z[i]][z[j]];
                result[i + 2][j] = white[i][j];
                result[i][j + 2] = yellow[i][j];
                result[i + 2][j + 2] = green[i][j];
            }
        }

        return result;

    }
    public static int[][] stage_3(int[][] img_matrix) {
        int[][] result = new int[8][8];
        for (int q = 0; q < 8; q++) {
            for (int w = 0; w < 8; w++)
                result[q][w] = img_matrix[q][w];
        }
        result[1][0] = result[1][0] - result[0][0];
        result[1][1] = result[1][1] - result[0][0];
        result[0][1] = result[0][1] - result[0][0];

        return result;

    }

    public static int[][] stage(int[][] img_matrix) {
        return stage_3(stage_2(stage_1(img_matrix)));
    }
    public static int[] left_top(int[][] img_matrix, int i, int j) {
        return new int[] {img_matrix[i][j - 1] - img_matrix[i][j],  //yellow
                img_matrix[i - 1][j - 1] - img_matrix[i][j],       //white
                img_matrix[i - 1][j] - img_matrix[i][j]};         //green
    }
    public static int[] right_top(int[][] img_matrix, int i, int j) {
        return new int[] {img_matrix[i + 1][j] - img_matrix[i][j],  //yellow
                img_matrix[i + 1][j - 1] - img_matrix[i][j],        //white
                img_matrix[i][j - 1] - img_matrix[i][j]};           //green
    }
    public static int[] left_down(int[][] img_matrix, int i, int j) {
        return new int[] {img_matrix[i - 1][j] - img_matrix[i][j], //yellow
                img_matrix[i - 1][j + 1] - img_matrix[i][j],       //white
                img_matrix[i][j + 1] - img_matrix[i][j]};           //green
    }
    public static int[] right_down(int[][] img_matrix, int i, int j) {
        return new int[] {img_matrix[i][j + 1] - img_matrix[i][j],      //yellow
                img_matrix[i + 1][j + 1] - img_matrix[i][j],            //white
                img_matrix[i + 1][j] - img_matrix[i][j]};               //green
    }

    public static int[][][] every_blocks(String img_name) {
        int[][] a = Grey.read_grey(img_name);
        int[][][] b = Split.to_8(a);
        int[][][] z = new int[b.length][8][8];

        for (int i = 0; i < b.length; i++) {
            z[i] = stage(b[i]);
        }

        return z;
    }
    public static void main(String[] args) {
        int[][] test = {
                {137, 143, 135, 138, 137, 136, 137, 138},
                {135, 138, 136, 137, 138, 140, 139, 135},
                {140, 139, 138, 139, 136, 137, 139, 137},
                {140, 143, 139, 139, 135, 136, 136, 134},
                {138, 139, 136, 138, 136, 135, 131, 138},
                {140, 137, 138, 137, 138, 132, 129, 136},
                {140, 140, 138, 143, 141, 138, 139, 139},
                {140, 142, 141, 137, 134, 138, 138, 137}
        };
        String img_name= "C:\\Users\\ZengHW\\Desktop\\h\\lena_gray.bmp";
        int[][] t = stage(test);
        int[][][] z = every_blocks(img_name);
        

        System.out.println(1);
    }
}
