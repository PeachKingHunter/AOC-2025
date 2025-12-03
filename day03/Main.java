// Imports
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Main {
  // Constant
  public static int NB_INT = 12;

  public static void main(String[] args) {
    // Variables
    File file = new File("input.txt");
    long res = 0L;

    // Read line by line the file
    try (Scanner myReader = new Scanner(file)) {
      while (myReader.hasNextLine()) {
        // Calcul the max of this bank for the line
        String strVal = myReader.nextLine();
        long maxVal = getMaxBanks(strVal);
        res += maxVal;
      }
    } catch (FileNotFoundException e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
    }

    // The answer
    System.out.println(res);
  }

  public static long getMaxBanks(String valStr) {
    // Variables
    int size = valStr.length();
    String highestNum = valStr.substring(size - NB_INT, size);

    // for each number at left of the begin's interval
    for (int i = size - NB_INT - 1; i >= 0; i--) {

      // Variables take a char from valStr and highestNum
      int num = valStr.charAt(i) - '0';
      int currentNum = highestNum.charAt(0) - '0';

      // Encounter a number biggest/equal than the first of the list
      if (num >= currentNum) {
        // Variables
        String tmp = "";
        boolean canMove = true;

        // Each number of the interval
        for (int j = 1; j < NB_INT; j++) {

          // Move numbers if needed for the adding of the new highest
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
        }

        // Add the new biggest number at the begining
        highestNum = num + tmp;
      }
    }

    // Print and return the max of this BANK
    System.out.println("> " + highestNum);
    return Long.parseLong(highestNum);
  }
}
