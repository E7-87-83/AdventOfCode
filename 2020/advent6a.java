// Advent 2020 Day 6

import java.util.Scanner;
import java.util.Arrays;

public class advent6a
{
    public static void main(String[] args)
    {
        Scanner scn = new Scanner(System.in);
        String incoming = scn.nextLine();
        int sum = 0;
        do 
        {
            int i = 0;
            String[] ans = new String[20];
            do {
                ans[i] = incoming;
                i++;
                incoming = scn.nextLine();
            } while (!(incoming.equals(""))); 
            
            boolean[][] hey = new boolean[i][26];
            for (int j=0; j<i; j++) {
                for (int k = 0; k < 26; k++) {
                    hey[j][k] = false;
                }
            }

            boolean[] finalhey = new boolean[26];
            Arrays.fill(finalhey, true);

            for (int j = 0; j<i; j++) {
                char[] ch = ans[j].toCharArray();
                for (char c : ch) {
                    int q = (int) c - 97;
                    hey[j][q] = true;
                }
            }

            for (int j = 0; j<i; j++) {
                for (int q = 0; q < 26; q++) {
                    finalhey[q] = hey[j][q] && finalhey[q];
                }
            }

            int counter = 0;
            for (int k = 0; k<26; k++) {
                if (finalhey[k]) {counter++;}
            }

            sum += counter;
            incoming = scn.nextLine();
        } while (!(incoming.equals("END")));

        System.out.println(sum);
    }
}

