// Advent Day 15
// 0 1 2 3 4 5 6 7 8 9
// 0 3 6 0 3 3 1 0 4 0

// Part II : ask for the 30_000_000th number
// LIMITATIONS: PREINPUT MUST HAVE 0 AND 1 BUT NOT END WITH 0 OR 1


import java.util.Scanner;
import java.util.Arrays;

public class advent15 {
    public static int myorder(int n,int[] arr, int coordbegin, int coordend) {
        for (int i = coordbegin-1; i >= coordend; i--) {
            if (arr[i]==n) {return i;}
        }
        return -1;
    }

    public static void main(String[] args) {
        Scanner scn = new Scanner(System.in);
        int[] num = new int[32000000];
        int[] order = new int[32000000];
        int[] orderOfZero = new int[32000000];
        Arrays.fill(order, -1);
        String in_num = scn.nextLine();
        int s = 0;
        int s0 = -1;
        do {
            num[s] = Integer.parseInt(in_num);
            if (num[s] == 0) {s0++; orderOfZero[s0]=s;}
            order[num[s]] = s;
            s++;
            in_num = scn.nextLine();
        } while (!(in_num.equals("")));

        System.out.println(s);
        System.out.println(num[s-1]);
        System.out.println(order[num[s-1]]);
        int j = s;
        while (j < 30000005) {
            if (num[j-1] != 0) {
                if (order[num[j-1]] < j-1 && order[num[j-1]] > -1) {
                    int here = j - 1 - order[num[j-1]];
                
                    if (here == 0) {
                        if (num[j-1]==num[j-2]) {
                            here = 1;
                        }// else {
                         //   here = myorder(num[j-1], num, j-1, 0);
                         // }
                    }

                    num[j] = here;
                    if (num[j] == 0) {s0++; orderOfZero[s0] = j;}
                } else {
                    num[j] = 0;
                    s0++; orderOfZero[s0]=j;
                }
            } else {
                num[j] = j - 1 - orderOfZero[s0-1];
                if (num[j] == 0) {s0++; orderOfZero[s0] = j;}
            }
            order[num[j-1]] = j-1;
            j++;
        }

        

        System.out.println("ans: " + num[29999999]);
    }
}
