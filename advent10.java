// Advent 2020 Day 10

import java.util.Scanner;
import java.util.Arrays;

public class advent10 {
    public static void main(String[] args) {
        Scanner scn = new Scanner(System.in);
        int[] adapter = new int[92];
       // int[] adapter = new int[11];
        int i = 0;
        String incoming = scn.nextLine();
        do {
            adapter[i] = Integer.parseInt(incoming);
            i++;
            incoming = scn.nextLine();
        } while (!(incoming.equals("")));

        Arrays.sort(adapter);
        System.out.println(Arrays.toString(adapter));

        int diff1 = 1;     //from the socket beside seat
        int diff3 = 0;
        for (int j = 0; j < i-1; j++) {
            switch (adapter[j+1]-adapter[j]) {
                case 1: diff1++; break;
                case 3: diff3++; break;
            } 
        }
        diff3++; // built-in joltage adapter
        
        System.out.println(diff1*diff3);
    }
}
