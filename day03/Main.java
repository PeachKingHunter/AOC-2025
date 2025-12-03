import java.io.File;                  // Import the File class
import java.io.FileNotFoundException; // Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files

public class Main {

  public static int NB_INT = 12;

  public static void main(String[] args) {
    File file = new File("input.txt");
    long res = 0L;

    // try-with-resources: Scanner will be closed automatically
    try (Scanner myReader = new Scanner(file)) {
      while (myReader.hasNextLine()) {
        String strVal = myReader.nextLine();
        long maxVal = getMaxBanks(strVal);
        res += maxVal;
      }
    } catch (FileNotFoundException e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
    }

    System.out.println(res);
  }

  public static long getMaxBanks(String valStr) {
    int size = valStr.length();
    System.out.println("");
    // System.out.println("");
    String highestNum = valStr.substring(size - NB_INT, size);
    // System.out.println(highestNum);

    for (int i = size - NB_INT - 1; i >= 0; i--) {

      int num = valStr.charAt(i) - '0';
      int currentNum = highestNum.charAt(0) - '0';
      // System.out.println(">>>" + num);
      if (num >= currentNum) {
        String tmp = "";
        boolean canMove = true;
        for (int j = 1; j < NB_INT; j++) {

          // System.out.println("--" + highestNum);

          if (canMove == true) {
            if (highestNum.charAt(j - 1) >= highestNum.charAt(j)) {
              tmp += highestNum.charAt(j - 1);
            } else {
              canMove = false;
              tmp += highestNum.charAt(j);
            }
          } else {
            tmp += highestNum.charAt(j);
          }

          // System.out.println("-" + highestNum);
        }
        highestNum = num + tmp;
      }
    }

    System.out.println("> " + highestNum);
    return Long.parseLong(highestNum);
  }
}
