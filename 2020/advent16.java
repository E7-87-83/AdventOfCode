// Advent Day 16

import java.util.Scanner;
import java.util.Arrays;
public class advent16 {
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
        String ticket = "";
        for (int k = 0; k<238; k++) {
            bool_valid = true;
            ticket = scn.nextLine();
            int[] term = new int[20];
            String[] str_terms = ticket.split(",");
            for (int r = 0; r < 20; r++) {
                term[r] = Integer.parseInt(str_terms[r]);
            }
            boolean c1, c2;
            int num = 0;
            outerloop:
            for (int r = 0; r < 20; r++) {
                num = 0;
                for (int i = 0; i < 20; i++) {
                     c1 = (check_begin1[i] <= term[r]) &&
                            (check_end1[i] >= term[r]); 
                     c2 = (check_begin2[i] <= term[r]) &&
                            (check_end2[i] >= term[r]); 
                     if (!c1 && !c2) { 
                         num++;
                     }
                }
                if ( num == 20 ) {
                    sum_invalid += term[r];
                    bool_valid = false;
                    num_invalid++;
                }
            }
            if (bool_valid) {
                System.out.println(ticket); 
            }
        }
        System.out.println(sum_invalid); 
    }
}
