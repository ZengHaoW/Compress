package Reading_image;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class RGB {
    public static Color[][] img2color(String imgfile){
        File file = new File(imgfile);
        BufferedImage bi = null;
        try {
            bi = ImageIO.read(file);
        } catch (Exception e) {
            e.printStackTrace();
        }

        int width = bi.getWidth();
        int height = bi.getHeight();
        int minx = bi.getMinX();
        int miny = bi.getMinY();
        Color[][] allcolor=new Color[height-miny][width-minx];
        for (int j = miny; j < height; j++) {
            for (int i = minx; i < width; i++) {
                int pixel = bi.getRGB(i, j);

                allcolor[j-miny][i-minx] = new Color(pixel);
            }
        }
        return allcolor;
    }
    public static int[][][] r_g_b(Color[][] allcolor) {
        int width = allcolor[0].length;
        int height = allcolor.length;
        int[][] r = new int[height][width];
        int[][] g = new int[height][width];
        int[][] b = new int[height][width];
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                r[i][j] = allcolor[i][j].getRed();
                g[i][j] = allcolor[i][j].getGreen();
                b[i][j] = allcolor[i][j].getBlue();
            }
        }
        return new int[][][] {r,g,b};
    }
    public static int[][][] read_rgb(String imagefilename) {
        Color[][] allcolor=img2color(imagefilename);
        int[][] red = r_g_b(allcolor)[0];
        int[][] green = r_g_b(allcolor)[1];
        int[][] blue = r_g_b(allcolor)[2];




       /* int[] red_temp = new int[height * width];
        int[] green_temp = new int[height * width];
        int[] blue_temp = new int[height * width];
        int z = 0;
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                red_temp[z] = red[i][j];
                green_temp[z] = green[i][j];
                blue_temp[z] = blue[i][j];
                z++;
            }
        }*/
        return new int[][][] {red, green, blue};
        //System.out.println(1);
    }
    public static void save_rgb(int[][][] k, String Output_path) {
        int[][] r = k[0];
        int[][] g = k[1];
        int[][] b = k[2];
        int height = r.length;
        int width = r[0].length;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int rgb = r[y][x];
                rgb = (rgb << 8) + g[y][x];
                rgb = (rgb << 8) + b[y][x];
                image.setRGB(x, y, rgb);
            }
        }
        System.out.println(1);
        File outputFile = new File(Output_path);
        try {
            ImageIO.write(image, "bmp", outputFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        int[][][] all_color=read_rgb("C:\\Users\\ZengHW\\Desktop\\f\\NB0001.bmp");  //image [hight][width] (左上开始)

        save_rgb(all_color, "C:\\Users\\ZengHW\\Desktop\\f\\NB0001-inverse.bmp");
        /*int width = allcolor[0].length;
        int height = allcolor.length;
        int[][] r = new int[height][width];
        int[][] g = new int[height][width];
        int[][] b = new int[height][width];
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                r[i][j] = allcolor[i][j].getRed();
                g[i][j] = allcolor[i][j].getGreen();
                b[i][j] = allcolor[i][j].getBlue();
            }
        }*/
        /*BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int rgb = r[y][x];
                rgb = (rgb << 8) + g[y][x];
                rgb = (rgb << 8) + b[y][x];
                image.setRGB(x, y, rgb);
            }
        }
        System.out.println(1);
        File outputFile = new File("C");
        try {
            ImageIO.write(image, "bmp", outputFile);
        } catch (IOException e) {
            e.printStackTrace();
        }*/
/*        for (Color[] onerow : allcolor) {
            for (Color color : onerow) {
                System.out.println(color);
            }*/
        //}
    }
}
