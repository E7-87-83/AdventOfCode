// Advent 2020 Day 8

import java.util.Scanner;
import java.util.Arrays;

public class advent8
{
    public static void main(String[] args)
    {
        int[] num = new int[620];
        char[] order = new char[620];
        
        Scanner scn = new Scanner(System.in);

        int i = 0;
        String incoming = scn.nextLine();
        do {
            order[i] = incoming.charAt(0);
            num[i] = Integer.parseInt(
                       incoming.substring(incoming.indexOf(" ")+1)
                     );
            i++;
            incoming = scn.nextLine();
        } while (!(incoming.equals("")));

        boolean[] appeared = new boolean[620];
        Arrays.fill(appeared, false);

        int cur = 0;
        int acc = 0;
        while (!appeared[cur]) {
            appeared[cur] = true;
            switch (order[cur]) {
                case 'n': cur++;break;
                case 'a': acc = acc+num[cur]; cur++; break;
                case 'j': cur = cur+num[cur]; break;
            }
        }
        System.out.println("line number repeated: " + cur);
        System.out.println("acc value: " + acc);

    }
}

