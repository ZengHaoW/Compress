package Chinese_remainder_theorem;

import Reading_image.RGB;

public class COMPRESS {
    public static long[][] compute_crt(int[][][] rgb) {
        int[][] red = rgb[0];
        int[][] green = rgb[1];
        int[][] blue = rgb[2];
        int height = red.length;
        int width = red[0].length;
        long[][] result = new long[height][width];

        for(int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                result[i][j] = CRT.Find_Min_X(new int[] {red[i][j], green[i][j], blue[i][j]});
            }
        }
        /*int l = red.length;
        int q = l % nums;
        t = (nums - q) % nums;
        int[] new_r = new int[l + t];
        int[] new_g = new int[l + t];
        int[] new_b = new int[l + t];
        if (q != 0) {

            int i = 0;
            for (; i < l; i++) {
                new_r[i] = red[i];
                new_g[i] = green[i];
                new_b[i] = blue[i];
            }
            for (int z = 0; z < t; z++) {
                new_r[i + z] = 0;
                new_g[i + z] = 0;
                new_b[i + z] = 0;
            }
        }
        else {
            new_r = red.clone();
            new_g = green.clone();
            new_b = blue.clone();
        }
        long[][] result = new long[3][(l+t) / nums];

        for (int i = 0; i < (l + t) / nums; i++) {
            result[0][i] = ans(new int[] {new_r[i * nums], new_r[i * nums + 1], new_r[i * nums + 2]}); //, new_r[i * nums + 2]
            result[1][i] = ans(new int[] {new_g[i * nums], new_g[i * nums + 1], new_g[i * nums + 2]}); //, new_g[i * nums + 2]
            result[2][i] = ans(new int[] {new_b[i * nums], new_b[i * nums + 1], new_b[i * nums + 2]}); //, new_b[i * nums + 2]
        }*/
        return result;
    }
    public static int[][][] inverse(long[][] c) {
        int height = c.length;;
        int width = c[0].length;
        int[][] r = new int[height][width];
        int[][] g = new int[height][width];
        int[][] b = new int[height][width];
        int[] temp;
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                temp = CRT.inverse(c[i][j]);
                r[i][j] = temp[0];
                g[i][j] = temp[1];
                b[i][j] = temp[2];
            }
        }
        /*int z = 0;
        int[][] result_r = new int[height][width];
        int[][] result_g = new int[height][width];
        int[][] result_b = new int[height][width];
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                result_r[i][j] = k[0][z];
                result_g[i][j] = k[1][z];
                result_b[i][j] = k[2][z];
                z++;
            }
        }*/
        return new int[][][] {r, g, b};
    }
    public static int number_of_pixels(int[][][] rgb) {
        return rgb[0][0].length * rgb[0].length;
    }
    public static int number_of_same_values(int[][][] rgb) {
        int[][] red = rgb[0];
        int[][] green = rgb[1];
        int[][] blue = rgb[2];
        int height = red.length;
        int width = red[0].length;
        int count1 = 0;

        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                if (red[i][j] == green[i][j])
                    if (green[i][j] == blue[i][j])
                        count1++;
            }
        }

        return count1;
    }
    public static long[] total_code_length(int[][][] rgb, long[][] crt) {
        int height = crt.length;
        int width = crt[0].length;
        long count1 = 0;
        long count2 = 0;
        long length1 = 0;
        long length2 = 0;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < height; j++) {
                for (int z = 0; z < width; z++) {
                    length1 = length1 + Integer.toBinaryString(rgb[i][j][z]).length();
                    count1++;
                }
            }
        }
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                length2 = length2 + Long.toBinaryString(crt[i][j]).length();
                count2++;
            }
        }

        return new long[] {length1, count1, length2, count2};
    }
    public static double[] avg_code_length(long[] total_code_length) {
        double avg_length_1 = 0;
        double avg_length_2 = 0;

        avg_length_1 = (double)total_code_length[0] / (double)total_code_length[1];
        avg_length_2 = (double)total_code_length[2] / (double)total_code_length[3];

        return new double[] {avg_length_1, avg_length_2};
    }
    public static int number_of_greater_than(long[][] crt, int num) {
        int height = crt.length;
        int width = crt[0].length;
        int count = 0;
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                if (crt[i][j] > Math.pow(2, num) - 1)
                    count++;
            }
        }
        return count;
    }
    public static void main(String[] args) {
        /*String file_path = "C:\\Users\\ZengHW\\Desktop\\h";
        String[] image_name = Get_image_name.get(file_path);*/
        String image_name = "C:\\Users\\ZengHW\\Desktop\\CALTECH-BMP-1500\\C0001.bmp";
        String inv_save_name = "C:\\Users\\ZengHW\\Desktop\\CALTECH-BMP-1500\\C0001_inverse.bmp";



        int[][][] rgb = RGB.read_rgb(image_name);
        long[][] crt = compute_crt(rgb);
        int[][][] inv = inverse(crt);
        int flag = 11111;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < inv.length; j++) {
                for (int z = 0; z < inv[0].length; z++) {
                    if (rgb[i][j][z] != inv[i][j][z])
                        flag = 00000;
                }
            }
        }
        System.out.println(flag);
        RGB.save_rgb(inv,inv_save_name);
        int total_number = number_of_pixels(rgb);
        int same_number = number_of_same_values(rgb);

        long[] total_length = total_code_length(rgb, crt);
        double[] avg_length = avg_code_length(total_length);
        System.out.println("原始图像像素个数，每个有rgb三个值: " + total_number);
        System.out.println("RGB三个值相同的个数: " + same_number);
        System.out.println("原始图像的总位长: " + total_length[0]);
        System.out.println("CRT处理后的总位长: " + total_length[2]);
        System.out.println("");
        System.out.println("原始图像的平均位长: " + avg_length[0]);
        System.out.println("CRT处理后的平均位长: " + avg_length[1]);

        int num1 = number_of_greater_than(crt, 8);
        int num2 = number_of_greater_than(crt, 16);
        int num3 = number_of_greater_than(crt, 24);
        System.out.println("greater than 2^8: " + num1);
        System.out.println("greater than 2^16: " + num2);
        System.out.println("greater than 2^24: " + num3);

    }
}
