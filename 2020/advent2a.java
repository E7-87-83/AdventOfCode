// Advent 2020 Day 2 Second Part

import java.util.Scanner;

public class advent2a
{
    public static void main(String[] args)
    {
        Scanner scn = new Scanner(System.in);
        String in_str = scn.nextLine();
        int answer = 0;
        do {
            String temp;
            int seperator = in_str.indexOf("-");
            temp = in_str.substring(0,seperator).trim();
            int num1 = Integer.parseInt(temp);
            int space = in_str.indexOf(" ");
            temp = in_str.substring(seperator+1, space).trim();
            int num2 = Integer.parseInt(temp);
            char suit = in_str.charAt(space+1);
            int colon = in_str.indexOf(":");
            String password = in_str.substring(colon+2);
            num1--;
            num2--;
            if (isValidPassword( num1 , num2, suit, password )) {answer++;}
            in_str = scn.nextLine();
        } while ( !in_str.equals("") );

        System.out.println(answer);

    } 
    public static boolean isValidPassword(int firstnum, int secondnum, char ch, String pw)
    {
       return ( ch == pw.charAt(firstnum)  ^  ch == pw.charAt(secondnum));
    }
}

