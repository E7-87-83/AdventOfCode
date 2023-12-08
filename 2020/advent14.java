// Advent 2020 Day 14
//
import java.util.Scanner;
import java.util.Arrays;

public class advent14
{
    public static String dec2bin(long myint) {
        String bin = "";
        do {
            if (myint%2 == 1) { bin = "1" +  bin; } else {bin = "0" + bin ;} 
            myint = myint/2;
        } while (myint != 0);
        return bin;
    }
    public static long bin2dec(String binstr) {
        long ans = 0;
        long pow_two = 1;
        for (int i = 35; i >= 0 ; i--) {
            if (binstr.charAt(i) == '1') {
                ans += pow_two;
            }
            pow_two *= 2;
        }
        return ans;
    }
    public static void main(String[] args)
    {
        String finalMemBinStr[] = new String[600];
        Arrays.fill(finalMemBinStr, "");
        
        Scanner scn = new Scanner(System.in);
        int[] memAddress = new int[600];
        long[] memValue = new long[600];
        String[] memBinStr = new String[600];
        int i = 0;
        String oops = scn.nextLine();
        String mask = "";
        do {
            if (oops.indexOf("mask") > -1 ) {
                mask = oops.substring(oops.indexOf("mask = ") + ("mask = ").length() );
                System.out.println("\nmask:\n" + mask);
            } else {
                String in_mem = oops;
                int helper1 = in_mem.indexOf("[");
                int helper2 = in_mem.indexOf("]");
                memAddress[i] = Integer.parseInt(in_mem.substring(helper1+1, helper2)); //helper2 + 1 ?
                int helperForVal = in_mem.indexOf(" = ")+3;
                memValue[i] = Integer.parseInt(in_mem.substring(helperForVal));
                memBinStr[i] = dec2bin(memValue[i]);
                int numOfZeros = 36 - memBinStr[i].length();
                for (int k = 0; k < numOfZeros; k++) {
                    memBinStr[i] = "0" + memBinStr[i];
                }
                System.out.println(memBinStr[i]);

                for (int k = 0; k < 36; k++) {
                    switch ( mask.charAt(k) ) {
                        case '0':
                            finalMemBinStr[i] += "0";
                            break;
                        case '1':
                            finalMemBinStr[i] += "1";
                            break;
                        case 'X': 
                            finalMemBinStr[i] += memBinStr[i].charAt(k);
                            break;
                        default: 
                            break;
                    }
                }
                i++;
            } 
            oops = scn.nextLine();
        } while (!oops.equals(""));


        long[] finalValues = new long[i];
        int[] Addresses = new int[i];
        int[] taskAddresses = new int[i];
        int counter = 0;
        boolean[] changed = new boolean[i];
        Arrays.fill(changed, false);
        for (int j = 0; j < i ; j++) {
            if (!changed[j]) {
                for (int k = i-1; k > j; k--) {
                    if ( (memAddress[j]==memAddress[k]) ) {
                        Addresses[counter] = memAddress[k];
                        taskAddresses[counter] = k;
                        if (!changed[k]) {counter++;}
                        changed[j] = true;
                        changed[k] = true;
                        System.out.println("repeat: " + memAddress[k]);
                        break;
                    }
                }
        
            }
            if (!changed[j]) {
                Addresses[counter] = memAddress[j];
                taskAddresses[counter] = j; 
                counter++;
            }
            
        }

        long sum = 0;
        for (int r = 0; r < counter; r++) {
            finalValues[r] = bin2dec(finalMemBinStr[taskAddresses[r]]);
            System.out.println(taskAddresses[r] + "  " + finalValues[r]);
            sum += finalValues[r];
        }
        System.out.println(sum);
    }
}
