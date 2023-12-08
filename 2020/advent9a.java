// Advent 2020 Day 9

import java.util.Scanner;
import java.util.Arrays;

public class advent9a
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

        long ans = num[i-1];
        int j = 0;
        boolean good = false;
        while (!good && j < i) {
           // int[] termOfSum = new int[5];
            long[] termOfSum = new long[300];
            good = false;
            long sum = num[j];
            termOfSum[0] = num[j];
            //for (int k2 = j+1; k2 < j+5; k2++) {
            for (int k2 = j+1; k2 < j+300; k2++) {
                termOfSum[k2-j] = num[k2];
                sum += termOfSum[k2-j];
                good = (sum==ans);
                if (good || (sum>ans) ) {break;}
            }

            if (good) {
                System.out.println( Arrays.toString(termOfSum) );
            } else {
                j++;
            }
        }
    }
}
