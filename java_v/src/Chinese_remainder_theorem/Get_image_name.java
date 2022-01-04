package Chinese_remainder_theorem;
import java.io.File;
public class Get_image_name {
    public static String[] get(String path){
        // get file list where the path has
        File file = new File(path);
        // get the folder list
        File[] array = file.listFiles();
        String[] image_name = new String[array.length];
        for(int i=0;i<array.length;i++){
            if(array[i].isFile()){
                // only take file name
                image_name[i] = array[i].getName();
                //System.out.println("^^^^^" + array[i].getName());
/*                // take file path and name
                System.out.println("#####" + array[i]);
                // take file path and name
                System.out.println("*****" + array[i].getPath());*/
            }else if(array[i].isDirectory()){
                get(array[i].getPath());
            }
        }
        return image_name;
    }
}
