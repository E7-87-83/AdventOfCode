// Advent 2020 Day 9

import java.util.Scanner;
import java.util.Arrays;

public class advent9 
{
    public static void main(String[] args) 
    {
        Scanner scn = new Scanner(System.in);
        long[] num = new long[1050];
        int i = 0;
        String incoming = scn.nextLine();
        do {
            num[i] = Long.parseLong(incoming);
            i++;
            incoming = scn.nextLine();
        } while (!(incoming.equals("")));

        int j = 26;
        boolean good = true;
        while (good) {
            good = false;
            outerloop:
            for (int k1 = j-26; k1 < j-1; k1++) {
                for (int k2 = k1+1; k2 < j; k2++) {
                    good = (num[k1]+num[k2]==num[j]);
                    if (good) {break outerloop;}
                }
            }

            if (!good) {
                System.out.println(num[j]);
            } else {
                j++;
            }
        }
    }
}
