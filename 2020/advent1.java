// Advent 2020 Day 1 

import java.util.Scanner;

public class advent1 
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

        for (int i = 0; i < 2020; i++) {
            if (arr[i] && arr[2020-i] ) {
                System.out.println(i*(2020-i));
            }
        }

    }
}

