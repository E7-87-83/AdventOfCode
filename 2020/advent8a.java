// Advent 2020 Day 8

import java.util.Scanner;
import java.util.Arrays;

public class advent8a
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

        System.out.println("Input finished.");

        boolean[] appeared = new boolean[1000];

        int cur = 0, acc = 0; 
        int wrongp = 0;
        int LINES = 619;
        System.out.println("Last line: " + order[LINES-1] + " " + num[LINES-1]);
        boolean fixed = false;
       
        while ( !fixed && cur < LINES && wrongp < LINES) {
            System.out.println("");
            Arrays.fill(appeared, false);
            cur = 0;
            acc = 0;
            if (order[wrongp] != 'a') {
                switch (order[wrongp]) {
                    case 'n': order[wrongp] = 'j'; break;
                    case 'j': order[wrongp] = 'n'; break;
                }
                while (!appeared[cur] && cur < LINES) {
                    appeared[cur] = true;
                    System.out.println(order[cur] + " " + num[cur]);
                    switch (order[cur]) {
                        case 'n': cur++;break;
                        case 'a': acc = acc+num[cur]; cur++; break;
                        case 'j': cur = cur+num[cur]; break;
                    }
                }
                switch (order[wrongp]) {
                    case 'n': order[wrongp] = 'j'; break;
                    case 'j': order[wrongp] = 'n'; break;
                }
                if (cur == LINES) {
                    System.out.println("wrong: " + wrongp);
                    System.out.println("acc value: " + acc);
                    fixed = true;
                }
            }
            wrongp++;
        }
       // System.out.println("line number repeated: " + cur);

    }
}

