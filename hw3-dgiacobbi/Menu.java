/**********************************************************************
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/9/22
 * HOMEWORK: HW-3
 * DESCRIPTION: This program consists of the methods related to the menu. It
 *              displays and the menu and calls methods from Database object.
 **********************************************************************/

import java.util.Scanner;

public class Menu {

    /*
    * Displays the user's database menu and ensures that the user input is an integer.
    *
    * @param kb: Scanner needed to take in user input
    * @return int of user's choice
    */
    public int displayMenu(Scanner kb) throws Exception{

        // Check if scanner is valid
        if (kb == null)
            throw new IllegalArgumentException();

        int user_choice = 0;
        boolean input_invalid = true;
        
        // Menu displayed
        String db_menu = "\n+-----------------------------------------------+\n" +
                           "|              CIA Database Menu                |\n" +
                           "+-----------------------------------------------+\n" +
                           "| 1. List countries                             |\n" +
                           "| 2. Add country                                |\n" +
                           "| 3. Find countries based on gdp and inflation  |\n" +
                           "| 4. Update country's gdp and inflation         |\n" +
                           "| 5. Exit                                       |\n" +
                           "+-----------------------------------------------+\n" +
                           "+ Enter your choice (1-5): ";

        // Continue to prompt for integer until user input is valid
        while(input_invalid) {

            try {
                System.out.print(db_menu);
                user_choice = kb.nextInt();

                input_invalid = false;
            
            } catch (Exception e) {
                System.out.println("Incorrect input. Please enter an integer 1-5.");
 
            } finally{
                kb.nextLine();
            }
        }
        return user_choice;
    }

    /*
    * Executes certain option within database depending on input given by the user
    *
    * @param user_choice: int of the choice input by user, cia_db: Database object used to call method per option,
             kb: Scanner needed to take in user input
    */
    public void executeOption(int user_choice, Database cia_db, Scanner kb){

        // Get connection to MariaDB to perform below actions
        cia_db.configDB();

        switch(user_choice) {

            // List countries in database
            case 1:
                cia_db.listCountries();
                break;
            
            // Add new country
            case 2:
                cia_db.addCountry(kb);
                break;
            
            // Find countries within certain gdp and inflation bounds
            case 3:
                cia_db.findCountry(kb);
                break;
            
            // Update a country's gdp and inflation
            case 4:
                cia_db.updateCountry(kb);
                break;
        }
    }
}