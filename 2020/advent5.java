// Advent 2020 Day 5

import java.util.Scanner;
import java.util.Arrays;

public class advent5
{
    public static void main (String[] args) {
        Scanner scn = new Scanner(System.in);
        int highestSeatID = 0;
        
        String myin = scn.nextLine();
        do {
            String strrow = myin.substring(0,7);
            String strcol = myin.substring(7,10);
            System.out.println(strrow + "  " + strcol);
            
            int unumrow = 127;
            int lnumrow = 0;
            int numrow;
            int pow_two = 128;
            for (int i = 0; i < 7; i++) {
                if (strrow.charAt(i) == 'F') {
                    lnumrow = lnumrow;
                    unumrow = lnumrow + pow_two/2;
                } else {
                    lnumrow += pow_two/2;
                    unumrow = unumrow;
                }

                pow_two /= 2;
            }
            numrow = lnumrow;

          //String strcol = "RLR";
            int unumcol = 7;
            int lnumcol = 0;
            int numcol;
            pow_two = 8;
            for (int i = 0; i < 3; i++) {
                if (strcol.charAt(i) == 'L') {
                   // lnumcol = lnumcol;
                    unumcol = lnumcol + pow_two/2;
                } else {
                    lnumcol += pow_two/2;
                   // unumcol = unumcol;
                }

                pow_two /= 2;
            }
            numcol = lnumcol;

            int seatID = numrow*8 + numcol;
            if (seatID > highestSeatID) {highestSeatID = seatID;}
            myin = scn.nextLine();
        } while (!(myin.equals("")));

        System.out.println(highestSeatID);

    }
}
