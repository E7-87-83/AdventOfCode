// Advent 2020 Day 6

import java.util.Scanner;
import java.util.Arrays;

public class advent6
{
    public static void main(String[] args)
    {
        Scanner scn = new Scanner(System.in);
        String incoming = "";
        int sum = 0;
        do 
        {
            boolean[] hey = new boolean[26];
            Arrays.fill(hey, false);
            int i = 0;
            String[] ans = new String[20];
            do {
                ans[i] = incoming;
                i++;
                incoming = scn.nextLine();
            } while (!(incoming.equals(""))); 
            
            for (int j = 0; j<i; j++) {
                char[] ch = ans[j].toCharArray();
                for (char c : ch) {
                    hey[(int) c - 97] = true;
                }
            }

            int counter = 0;
            for (int k = 0; k<26; k++) {
                if (hey[k]) {counter++;}
            }

            sum += counter;
            incoming = scn.nextLine();
        } while (!(incoming.equals("END")));

        System.out.println(sum);
    }
}

