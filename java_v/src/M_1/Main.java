package M_1;

import Reading_image.Grey;

public class Main {
    public static void main(String[] args) {

        String img_name = "C:\\Users\\ZengHW\\Desktop\\h\\lena_gray.bmp";
        int[][] a = Grey.read_grey(img_name);
        int[][][] b = Split.to_8(a);
        int[][][] z = Compute.every_blocks(img_name);
        String[] c = Code.Encoding_2(z);
        int length = Code.compute_length(c);

        System.out.println(z.length * z[0].length * z[0][0].length * 8);
        System.out.println(length);
    }
}
