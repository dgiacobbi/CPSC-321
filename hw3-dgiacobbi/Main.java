/**********************************************************************
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/9/22
 * HOMEWORK: HW-3
 * DESCRIPTION: This program keeps the menu display running as user input is taken in.
 *              It also closes the program after interaction is complete.
 **********************************************************************/

import java.util.Scanner;

public class Main {

    public static void main(String[] args){
        
        // Create new objects to interact with user and database
        Scanner kb = new Scanner(System.in);
        Database cia_db = new Database();
        int user_choice = 0;

        // Continue to prompt menu after every input until user wants to exit program
        while (user_choice != 5){

            try {
                // Display new menu to take in input
                Menu cia_menu = new Menu();
                user_choice = cia_menu.displayMenu(kb);

                // Connect to database and carry out queries based on user input
                cia_menu.executeOption(user_choice, cia_db, kb);

            } catch (Exception ex) {
                System.out.println("displayMenu error occurred");
                System.out.println(ex.toString());
            }   
        }
        // Exit program and close scanner
        System.out.println("Closing program. Goodbye!");
        kb.close();  
    }   
}