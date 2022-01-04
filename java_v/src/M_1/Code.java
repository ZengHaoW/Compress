package M_1;

import java.util.function.IntBinaryOperator;

public class Code {
    public static String[] Encoding_1(int[][][] img_matrix) {
        int[][] temp_1 = new int[img_matrix[0].length][img_matrix[0][0].length];
        String[] temp_2 = new String[img_matrix.length];
        for (int i = 0; i < img_matrix.length; i++) {
            temp_1 = method_1(img_matrix[i]);
            temp_2[i] = code(temp_1);
        }
        return temp_2;
    }
    public static String[] Encoding_2(int[][][] img_matrix) {
        int[][] temp_1 = new int[img_matrix[0].length][img_matrix[0][0].length];
        String[] temp_2 = new String[img_matrix.length];
        for (int i = 0; i < img_matrix.length; i++) {
            if (i == 0)
                temp_1 = img_matrix[i];
            else
                temp_1 = method_2(img_matrix[i - 1], img_matrix[i]);
            temp_2[i] = code(temp_1);
        }
        return temp_2;
    }

    public static int compute_length(String[] total_code) {
        int count = 0;
        for (String s: total_code)
            count = count + s.length();
        return count;
    }

    public static int[][] method_1(int[][] block_8_8) {
        int[][] result = new int[block_8_8.length][block_8_8[0].length];
        for (int i = 0; i < block_8_8[0].length; i++) {
            for (int j = 0; j < block_8_8.length; j++) {
                if (j == 0 && i == 0) {
                    result[i][j] = block_8_8[i][j];
                    continue;
                }
                else if (j == 0)
                    result[j][i] = block_8_8[j][i] - block_8_8[7][i - 1];
                else
                    result[j][i] = block_8_8[j][i] - block_8_8[j - 1][i];
            }
        }
        return result;
    }

    public static int[][] method_2(int[][] block_1, int[][] block_2) {
        int[][] temp = new int[block_1.length][block_1[0].length];
        for (int i = 0; i < block_1.length; i++) {
            for (int j = 0; j < block_1[0].length; j++) {
                temp[i][j] = block_2[i][j] - block_1[i][j];
            }
        }
        return temp;
    }

    public static String code(int[][] block) {
        String result = "";
        for (int i = 0; i < block[0].length; i++) {
            for (int j = 0; j < block.length; j++) {
                if (block[j][i] == 0) {
                    result = result + "000";
                }
                else if (Math.abs(block[j][i]) <= 1 && Math.abs(block[j][i]) >= 1) {
                    if (block[j][i] < 0) {
                        char[] temp = Integer.toBinaryString(Math.abs(block[j][i])).toCharArray();
                        for (int r = 0; r < temp.length; r++) {
                            if (temp[r] == '1')
                                temp[r] = '0';
                            else
                                temp[r] = '1';
                        }
                        result = result + "001" + String.valueOf(temp);
                    }
                    else
                        result = result + "001" + Integer.toBinaryString(block[j][i]);

                }
                else if (Math.abs(block[j][i]) <= 3 && Math.abs(block[j][i]) >= 2) {
                   if (block[j][i] < 0) {
                       char[] temp = Integer.toBinaryString(Math.abs(block[j][i])).toCharArray();
                       for (int r = 0; r < temp.length; r++) {
                           if (temp[r] == '1')
                               temp[r] = '0';
                           else
                               temp[r] = '1';
                       }
                       result = result + "010" + String.valueOf(temp);
                   }
                   else
                       result = result + "010" + Integer.toBinaryString(block[j][i]);

                }
                else if (Math.abs(block[j][i]) <= 7 && Math.abs(block[j][i]) >= 4) {
                    if (block[j][i] < 0) {
                        char[] temp = Integer.toBinaryString(Math.abs(block[j][i])).toCharArray();
                        for (int r = 0; r < temp.length; r++) {
                            if (temp[r] == '1')
                                temp[r] = '0';
                            else
                                temp[r] = '1';
                        }
                        result = result + "011" + String.valueOf(temp);
                    }
                    else
                        result = result + "011" + Integer.toBinaryString(block[j][i]);

                }
                else if (Math.abs(block[j][i]) <= 15 && Math.abs(block[j][i]) >= 8) {
                    if (block[j][i] < 0) {
                        char[] temp = Integer.toBinaryString(Math.abs(block[j][i])).toCharArray();
                        for (int r = 0; r < temp.length; r++) {
                            if (temp[r] == '1')
                                temp[r] = '0';
                            else
                                temp[r] = '1';
                        }
                        result = result + "100" + String.valueOf(temp);
                    }
                    else
                        result = result + "100" + Integer.toBinaryString(block[j][i]);

                }
                else if (Math.abs(block[j][i]) <= 31 && Math.abs(block[j][i]) >= 16) {
                    if (block[j][i] < 0) {
                        char[] temp = Integer.toBinaryString(Math.abs(block[j][i])).toCharArray();
                        for (int r = 0; r < temp.length; r++) {
                            if (temp[r] == '1')
                                temp[r] = '0';
                            else
                                temp[r] = '1';
                        }
                        result = result + "101" + String.valueOf(temp);
                    }
                    else
                        result = result + "101" + Integer.toBinaryString(block[j][i]);

                }
                else if (Math.abs(block[j][i]) <= 63 && Math.abs(block[j][i]) >= 32) {
                    if (block[j][i] < 0) {
                        char[] temp = Integer.toBinaryString(Math.abs(block[j][i])).toCharArray();
                        for (int r = 0; r < temp.length; r++) {
                            if (temp[r] == '1')
                                temp[r] = '0';
                            else
                                temp[r] = '1';
                        }
                        result = result + "1100" + String.valueOf(temp);
                    }
                    else
                        result = result + "1100" + Integer.toBinaryString(block[j][i]);

                }
                else if (Math.abs(block[j][i]) <= 127 && Math.abs(block[j][i]) >= 64) {
                    if (block[j][i] < 0) {
                        char[] temp = Integer.toBinaryString(Math.abs(block[j][i])).toCharArray();
                        for (int r = 0; r < temp.length; r++) {
                            if (temp[r] == '1')
                                temp[r] = '0';
                            else
                                temp[r] = '1';
                        }
                        result = result + "1101" + String.valueOf(temp);
                    }
                    else
                        result = result + "1101" + Integer.toBinaryString(block[j][i]);

                }
                else if (Math.abs(block[j][i]) <= 255 && Math.abs(block[j][i]) >= 128) {
                    if (block[j][i] < 0) {
                        char[] temp = Integer.toBinaryString(Math.abs(block[j][i])).toCharArray();
                        for (int r = 0; r < temp.length; r++) {
                            if (temp[r] == '1')
                                temp[r] = '0';
                            else
                                temp[r] = '1';
                        }
                        result = result + "1110" + String.valueOf(temp);
                    }
                    else
                        result = result + "1110" + Integer.toBinaryString(block[j][i]);

                }
                else if (Math.abs(block[j][i]) <= 511 && Math.abs(block[j][i]) >= 256) {
                    if (block[j][i] < 0) {
                        char[] temp = Integer.toBinaryString(Math.abs(block[j][i])).toCharArray();
                        for (int r = 0; r < temp.length; r++) {
                            if (temp[r] == '1')
                                temp[r] = '0';
                            else
                                temp[r] = '1';
                        }
                        result = result + "1111" + String.valueOf(temp);
                    }
                    else
                        result = result + "1111" + Integer.toBinaryString(block[j][i]);

                }
            }
        }
        return result;
    }


    public static void main(String[] args) {
        int[][] test1 = {
                {137, 143, 135, 138, 137, 136, 137, 138},
                {135, 138, 136, 137, 138, 140, 139, 135},
                {140, 139, 138, 139, 136, 137, 139, 137},
                {140, 143, 139, 139, 135, 136, 136, 134},
                {138, 139, 136, 138, 136, 135, 131, 138},
                {140, 137, 138, 137, 138, 132, 129, 136},
                {140, 140, 138, 143, 141, 138, 139, 139},
                {140, 142, 141, 137, 134, 138, 138, 137}
        };
        int[][] test2 = {
                {138, -1, 1, 3, -3, -1, -2, -2},
                {0, -6, 0, -3, 4, 1, -1, -2},
                {0, 2, -2, 2, 3, -2, 6, 2},
                {2, 7, -1, 6, 2, 5, 0, 0},
                {-1, 2, -3, -1, 5, 1, -4, -4},
                {1, 1, -2, -5, 1, 1, -1, -3},
                {1, 0, 4, 9, 2, -1, 3, 7},
                {0, -1, -4, -2, 0, 3, 3, -1}
        };
        int w = 4;
        int q = -4;
        int[][] z = method_1(test2);
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++)
                System.out.print(z[j][i] + " ");
            System.out.println("");
        }
        String t = code(z);
        System.out.println(t);
        System.out.println(t.length());
    }
}
