// Advent Day 16

import java.util.Scanner;
import java.util.Arrays;
public class advent16a {
    public static void main(String[] args) {
        int[] check_begin1 = new int[20];
        int[] check_end1 = new int[20];
        int[] check_begin2 = new int[20];
        int[] check_end2 = new int[20];
        Scanner scn = new Scanner(System.in);
        for (int i = 0; i<20; i = i+1) {
            String temp = scn.nextLine();
            int t = temp.indexOf("-");
            check_begin1[i] = Integer.parseInt(temp.substring(0,t));
            check_end1[i] = Integer.parseInt(temp.substring(t+1));
            temp = scn.nextLine();
            t = temp.indexOf("-");
            check_begin2[i] = Integer.parseInt(temp.substring(0,t));
            check_end2[i] = Integer.parseInt(temp.substring(t+1));
        }
    
        boolean bool_valid = true;
        int num_invalid = 0;
        int sum_invalid = 0;
        boolean[][] fieldOrderOK = new boolean[20][20];  
        // O: printed order
        // K: official order
        String ticket = "";
        int[][] term = new int[191][20];
        for (int k = 0; k<191; k++) {
            ticket = scn.nextLine();
            String[] str_terms = ticket.split(",");
            for (int r = 0; r < 20; r++) {
                term[k][r] = Integer.parseInt(str_terms[r]);
            }
        }
        //System.out.println(term[190][19]); // safety check 
        
        for (int r = 0; r<20; r++) {
            for (int i = 0; i<20; i++) {
                int num = 0;
                boolean c1, c2;
                outerloop:
                for (int k=0; k<191; k++) {
                    c1 = (check_begin1[i] <= term[k][r]) &&
                            (check_end1[i] >= term[k][r]); 
                    c2 = (check_begin2[i] <= term[k][r]) &&
                            (check_end2[i] >= term[k][r]); 
                    if (c1 || c2) {
                        num++;
                    } else {
                        fieldOrderOK[r][i] = false; 
                        break outerloop;
                    }
                }    
                if (num == 191) {
                    fieldOrderOK[r][i] = true;
                } // else { 
              // fieldOrderOK[r][i] = false;
            //}
            }
        }

        for (int r=0; r<20; r++) {
            for (int i=0; i<20; i++) {
                if (fieldOrderOK[r][i]) {System.out.print(i + " ");}
            }
            System.out.println("");
        }

        /*
            boolean c1, c2;
            int num = 0;
            outerloop:
            for (int r = 0; r < 20; r++) {
                for (int i = 0; i < 20; i++) {
                     c1 = (check_begin1[i] <= term[r]) &&
                            (check_end1[i] >= term[r]); 
                     c2 = (check_begin2[i] <= term[r]) &&
                            (check_end2[i] >= term[r]); 
                     if (!c1 && !c2) { 
                         ;
                     }
                }
                if ( num == 20 ) {
                    sum_invalid += term[r];
                    bool_valid = false;
                    num_invalid++;
                    break outerloop;
                }
            }
            if (bool_valid) {
                System.out.println(ticket); 
            }
        }
        // System.out.println(num_invalid);
        System.out.println(num_invalid); // safety check 
        */
    }
}
