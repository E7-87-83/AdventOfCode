import java.util.Scanner;

public class advent12
{

    public static void main(String[] args) {
        int faceStatusEW = 1;
        int faceStatusNS = 0;
        int locationX = 0;
        int locationY = 0;
        int direction = 90 ;
        Scanner scn = new Scanner(System.in);
        String line = scn.nextLine();
        do {
            int num = Integer.parseInt(line.substring(1));
            switch (line.charAt(0)) {
                case 'E': locationX += num; break;
                case 'W': locationX -= num; break;
                case 'S': locationY -= num; break;
                case 'N': locationY += num; break; 
                case 'F': locationX += faceStatusEW*num;
                          locationY += faceStatusNS*num;
                          break;
                case 'R': direction = (direction + num + 360) % 360;break;
                case 'L': direction = (direction - num + 360) % 360;break;
            
            }
            if (line.charAt(0) == 'R' || line.charAt(0) == 'L') {
                switch (direction) {
                    case 0: faceStatusNS = 1; faceStatusEW = 0; break;
                    case 90: faceStatusNS = 0; faceStatusEW = 1; break;
                    case 180: faceStatusNS = -1; faceStatusEW = 0; break;
                    case 270: faceStatusNS = 0; faceStatusEW = -1; break;
                }
            }
            System.out.println(locationX + " " + locationY + "     " + line );
            line = scn.nextLine();
        } while (!line.equals(""));

        int s1 = 0, s2 = 0; 
        if (locationX < 0) {s1=locationX*-1;} else {s1=locationX;}
        if (locationY < 0) {s2=locationY*-1;} else {s2=locationY;}
        System.out.println(s1+s2);

    }
}
