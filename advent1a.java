// Advent 2020 Day 1 Second Part

import java.util.Scanner;

public class advent1a
{
    public static void main(String[] args)
    {
        boolean[] arr = new boolean[2020];
        Scanner scn = new Scanner(System.in);
        String in_num = scn.nextLine();
        int count = 0;
        do {
            arr[Integer.parseInt(in_num)] = true;
            count++;
            in_num = scn.nextLine();
        } while ( !in_num.equals("") );

        
        for (int i = 0; i < 2019; i++) {
            for (int j = i+1; j < 2020; j++) {
                if (i+j < 2020) {
                    if ( arr[i] && arr[j] && arr[2020-i-j] ) {
                        System.out.println(i*j*(2020-i-j));
                    }
                }
            }
        }

    }
}

