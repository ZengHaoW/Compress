package Reading_image;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.io.File;
import java.io.IOException;

public class Grey {
    public static int[][] read_grey(String img_name) {
        File file = new File(img_name);
        BufferedImage img = null;
        try {
            img = ImageIO.read(file);
        } catch (Exception e) {
            e.printStackTrace();
        }

        int width = img.getWidth();
        int height = img.getHeight();
        int[][] imgArr = new int[width][height];
        Raster raster = img.getData();
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                imgArr[i][j] = raster.getSample(i, j, 0);
            }
        }
        return imgArr;
    }
    public static void main(String[] args) throws IOException {
        /*File file = new File("C:\\Users\\ZengHW\\Desktop\\h\\lena_grey.bmp");
        BufferedImage img = ImageIO.read(file);*/
        String imgfile = "C:\\Users\\ZengHW\\Desktop\\h\\lena_gray.jpg";
        int[][] a = read_grey(imgfile);// [W, H]
        System.out.println(1);
    }
}
