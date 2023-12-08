// Advent 2020 Day 2

import java.util.Scanner;

public class advent2
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
            int min = Integer.parseInt(temp);
            int space = in_str.indexOf(" ");
            temp = in_str.substring(seperator+1, space).trim();
            int max = Integer.parseInt(temp);
            char suit = in_str.charAt(space+1);
            int colon = in_str.indexOf(":");
            String password = in_str.substring(colon+1);
            if (isValidPassword( min , max, suit, password )) {answer++;}
            in_str = scn.nextLine();
        } while ( !in_str.equals("") );

        System.out.println(answer);

    } 
    public static boolean isValidPassword(int atLeast, int atMost, char ch, String pw)
    {
       int count = 0;
       for (int i=0; i< pw.length(); i++) {
           if (ch == pw.charAt(i)) {count++;}
       } 
       
       boolean criterion = ( atLeast <= count && atMost >= count );
       return criterion; 
    }
}

