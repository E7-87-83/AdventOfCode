// Advent 2020 Day 11
//
import java.util.Scanner;
import java.util.Arrays;

public class advent11 {
    public static void main(String[] args) {
       

        Scanner scn = new Scanner(System.in);
        String[] incoming = new String[600];
        Arrays.fill(incoming, "");
        int i = -1;
        do {
            i++;
            incoming[i] = scn.nextLine();
        } while (!(incoming[i].equals("")));
        
        int width = incoming[0].length();
        int height = i;

        char[][] ground = new char[height][width];
        for (int j = 0; j < height; j++) {
            ground[j] = incoming[j].toCharArray();
        }




        int change = 100;
       


        while (change != 0) {
            change = 0;

            int[][] bground = new int[height][width];
            for (int j = 0; j < height; j++) {
                for (int k = 0; k < width; k++) {
                    switch (ground[j][k]) {
                        case '#': bground[j][k] = 1; break;
                        case 'L': bground[j][k] = 0; break;
                        case '.': bground[j][k] = 0; break;
                        default: break;
                    }
                }
            }

            char[][] oldGround = new char[height][width];
            oldGround = ground;
          

            int j0 = 0;
            for (int k = 1; k < width-1; k++) {
                if (oldGround[j0][k]=='#') {
                    if ( 
                        bground[j0][k+1]+ bground[j0][k-1]+
                        bground[j0+1][k+1]+ bground[j0+1][k]+ bground[j0+1][k-1]      
                                                         >= 4) 
                    {
                        ground[j0][k] = 'L';
                        change++;
                    }
                }
                if (oldGround[j0][k]=='L') {
                    if ( 
                        bground[j0][k+1]+ bground[j0][k-1]+
                        bground[j0+1][k+1]+ bground[j0+1][k]+ bground[j0+1][k-1]      
                                                         == 0) 
                    {
                        ground[j0][k] = '#';
                        change++;
                    }
                }
            }

            for (int j = 1; j <height-1; j++) {
                int t = 0;
                if (oldGround[j][t]=='#') {
                    if (bground[j+1][t]+  bground[j+1][t+1]+ 
                        bground[j][t+1]+
                        bground[j-1][t+1]+ bground[j-1][t]                       
                                                         >= 4)  
                    {
                        ground[j][t] = 'L';
                        change++;
                    }
                }
                if (oldGround[j][t]=='L') {
                    if (bground[j+1][t]+  bground[j+1][t+1]+ 
                        bground[j][t+1]+
                        bground[j-1][t+1]+ bground[j-1][t]                       
                                                         == 0)  
                    {
                        ground[j][t] = '#';
                        change++;
                    }
                }


        
                for (int k = 1; k < width-1; k++) {
                    if (oldGround[j][k]=='#') {
                        if (bground[j+1][k]+  bground[j+1][k+1]+ 
                            bground[j+1][k-1]+ bground[j][k+1]+ bground[j][k-1]+
                            bground[j-1][k+1]+ bground[j-1][k]+ bground[j-1][k-1]      
                                                             >= 4) 
                        {
                            ground[j][k] = 'L';
                            change++;
                        }
                    }
                    if (oldGround[j][k]=='L') {
                        if (bground[j+1][k]+  bground[j+1][k+1]+ 
                            bground[j+1][k-1]+ bground[j][k+1]+ bground[j][k-1]+
                            bground[j-1][k+1]+ bground[j-1][k]+ bground[j-1][k-1]      
                                                             == 0) 
                        {
                            ground[j][k] = '#';
                            change++;
                        }
                    }
                }
       




                t = width-1;
                
                if (oldGround[j][t]=='#') {
                    if (bground[j+1][t]+  bground[j+1][t-1]+ 
                        bground[j][t-1]+
                        bground[j-1][t-1]+ bground[j-1][t]                       
                                                         >= 4)  
                    {
                        ground[j][t] = 'L';
                        change++;
                    }
                }
                if (oldGround[j][t]=='L') {
                    if (bground[j+1][t]+  bground[j+1][t-1]+ 
                        bground[j][t-1]+
                        bground[j-1][t-1]+ bground[j-1][t]                       
                                                         == 0)  
                    {
                        ground[j][t] = '#';
                        change++;
                    }
                }

                
            }

            int je = height-1; 
            for (int k = 1; k < width-1; k++) {
                if (oldGround[je][k]=='#') {
                    if ( 
                         bground[je][k+1]+ bground[je][k-1]+
                        bground[je-1][k+1]+ bground[je-1][k]+ bground[je-1][k-1]      
                                                         >= 4) 
                    {
                        ground[je][k] = 'L';
                        change++;
                    }
                }
                if (oldGround[je][k]=='L') {
                    if ( 
                        bground[je][k+1]+ bground[je][k-1]+
                        bground[je-1][k+1]+ bground[je-1][k]+ bground[je-1][k-1]      
                                                         == 0) 
                    {
                        ground[je][k] = '#';
                        change++;
                    }
                }
            }

            // four corners
            if ((oldGround[0][0] == 'L') && (bground[0][1]+bground[1][1]+bground[1][0] == 0)) {
                ground[0][0] = '#';
                change++;
            }

            if ((oldGround[je][0] == 'L') && (bground[je][1]+bground[je-1][1]+bground[je][0] == 0)) {
                ground[je][0] = '#';
                change++;
            }

            int ke = width-1;
            if ((oldGround[0][ke] == 'L') && (bground[0][ke-1]+bground[1][ke]+bground[1][ke-1] == 0)) {
                ground[0][ke] = '#';
                change++;
            }

            if ((oldGround[je][ke] == 'L') && (bground[je-1][ke-1]+bground[je-1][ke]+bground[je][ke-1] == 0)) {
                ground[je][ke] = '#';
                change++;
            }

        }

        int counter = 0;
        for (int j = 0; j < height; j++) {
            for (int k = 0; k < width; k++)
                {if (ground[j][k]=='#') {counter++;} }
        }
        System.out.println(counter);

    }


}
