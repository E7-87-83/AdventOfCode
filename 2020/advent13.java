// Advent 2020 Day 13

import java.util.Scanner;

public class advent13
{
    public static void main(String[] args)
    {
        Scanner scn = new Scanner(System.in);
        int timestamp = Integer.parseInt(scn.nextLine());
        int[] busid = new int[60];
        String[] str_busid = scn.nextLine().split(",");
        int j = 0;
        for (int i=0; i < str_busid.length ;i++) {
            if (!(str_busid[i].equals("x"))) {
                busid[j] = Integer.parseInt(str_busid[i]);
                j++;
            }
        }
        int miniWaitTime = 1000;
        int miniWaitBusID = 0;
        for (int k = 0; k < j; k++) {
            int rmd = busid[k] - (timestamp % busid[k]);
            if (rmd < miniWaitTime) {
                miniWaitTime = rmd;
                miniWaitBusID = busid[k];
            } 
        }

        System.out.println("Bus ID: " + miniWaitBusID);
        System.out.println("Minimum Waiting Time: " + miniWaitTime);
        System.out.println("ANS :" + miniWaitBusID * miniWaitTime);
    }
}

