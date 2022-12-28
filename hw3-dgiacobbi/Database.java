/**********************************************************************
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/9/22
 * HOMEWORK: HW-3
 * DESCRIPTION: This program contains all of the methods related to the Maria
 *              DB Database. It also sets up the connection to Database server.
 **********************************************************************/

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Scanner;

public class Database {

    // Used to connect to the database for each user option
    public Connection cn;

    /*
    * Connects to the MariaDB server using the credentials found in config.properties.
    */
    public void configDB(){

        try {
            // Connection info retrieved from config.properties
            Properties prop = new Properties();
            FileInputStream in = new FileInputStream("config.properties");
            prop.load(in);
            in.close();

            // Connect to database by piecing credentials together
            String hst = prop.getProperty("host");
            String usr = prop.getProperty("user");
            String pwd = prop.getProperty("password");
            String dab = "dgiacobbi_DB";
            String url = "jdbc:mysql://" + hst + "/" + dab;
            cn = DriverManager.getConnection(url, usr, pwd);
        } 
        catch(Exception e){

            System.out.println("Error occurred with database configuration");
            e.printStackTrace();
        }
    }
    

    /*
    * Lists all of the countries, their code, gdp, and inflation rates from the CIA database.
    */
    public void listCountries(){

        try {
            // Create and execute query
            Statement st = cn.createStatement();
            String q = "SELECT * FROM Country";
            ResultSet rs = st.executeQuery(q);
        
            // Print the results in a neatly formatted line
            while(rs.next()) {
                String code = rs.getString("country_code");
                String name = rs.getString("country_name");
                String gdp = rs.getString("gdp");
                String inflation = rs.getString("inflation");
                System.out.println(name + " (" + code + "), " + "per capita gdp $" + gdp
                                    + ", " + "inflation rate " + inflation + "%");
            }
            // Close all connection and query objects
            st.close();
            rs.close();
            this.cn.close();
        }
        catch(SQLException e) {
            System.out.println("listCountries error occurred");
            e.printStackTrace();
        }
    }

    /*
    * Adds a country to the database based on the user's input. Notified if country already exists.
    *
    * @param kb: Scanner needed to take in user input
    */
    public void addCountry(Scanner kb){
        
        String user_code, user_name, user_gdp, user_inflation;

        try {

            // Prompt user for country code
            System.out.print("Country code................: ");
            user_code = kb.nextLine();

            // Check if country code already exists and notify user if it does
            String q1 = "SELECT * FROM Country WHERE country_code = ?";
            PreparedStatement st = cn.prepareStatement(q1);
            st.setString(1, user_code);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                System.out.println("This country already exists.");
                rs.close();
                st.close();
                return;
            }

            // If country does not already exist, prompt user for other info
            System.out.print("Country name................: ");
            user_name = kb.nextLine();

            System.out.print("Country per capita gdp (USD): ");
            user_gdp = kb.nextLine();

            System.out.print("Country inflation (pct).....: ");
            user_inflation = kb.nextLine();

            // Create a prepared statement to insert into database w/ user input
            String q = "INSERT INTO Country VALUES (?,?,?,?)";
            st = cn.prepareStatement(q);

            st.setString(1, user_code);
            st.setString(2, user_name);
            st.setString(3, user_gdp);
            st.setString(4, user_inflation);
            st.execute();
        
            // Notify new country has been added
            System.out.println("\n" + user_name + " (" + user_code + ") has been added to the CIA database!");
            this.cn.close();
        }
        catch(SQLException e) {

            System.out.println("addCountry error occurred");
            e.printStackTrace();
        }
    }

    /*
    * Displays a countries within a given inclusive range of gdp and inflation provided by the user.
    *
    * @param kb: Scanner needed to take in user input
    */
    public void findCountry(Scanner kb){
        
        String gdp_min, gdp_max, inflation_min, inflation_max;

        try {

            // Prompt user for bounds of the query for country search
            System.out.print("Minimum per capita gdp (USD)..: ");
            gdp_min = kb.nextLine();

            System.out.print("Maximum per capita gdp (USD)..: ");
            gdp_max = kb.nextLine();

            System.out.print("Minimum inflation (pct).......: ");
            inflation_min = kb.nextLine();

            System.out.print("Maximum inflation (pct).......: ");
            inflation_max = kb.nextLine();

            // Create a prepared statement with given user bounds and execute query
            String q = "SELECT * FROM Country " +
                       "WHERE gdp >= ? AND gdp <= ? AND inflation >= ? AND inflation <= ? " +
                       "ORDER BY gdp, inflation";
            PreparedStatement st = cn.prepareStatement(q);
            st.setInt(1, Integer.parseInt(gdp_min));
            st.setInt(2, Integer.parseInt(gdp_max));
            st.setDouble(3, Double.parseDouble(inflation_min));
            st.setDouble(4, Double.parseDouble(inflation_max));
            ResultSet rs = st.executeQuery();
        
            // Print results in a neatly formatted manner
            while(rs.next()) {
                String code = rs.getString("country_code");
                String name = rs.getString("country_name");
                String gdp = rs.getString("gdp");
                String inflation = rs.getString("inflation");
                System.out.println(name + " (" + code + "), " + "per capita gdp $" + gdp
                                    + ", " + "inflation rate " + inflation + "%");
            }
        }
        catch(SQLException e) {

            System.out.println("findCountry error occurred");
            e.printStackTrace();
        }
    }

    /*
    * Updates a country's current gdp and inflation with user input. Notifies user if 
    * they attempt to input a country that does not exist
    *
    * @param kb: Scanner needed to take in user input
    */
    public void updateCountry(Scanner kb){

        String user_code, user_gdp, user_inflation;
        
        try {

            // Checks country code
            System.out.print("Country code................: ");
            user_code = kb.nextLine();

            // Notifies if country does not exist based on user input
            String q1 = "SELECT * FROM Country WHERE country_code = ?";
            PreparedStatement st = cn.prepareStatement(q1);
            st.setString(1, user_code);
            ResultSet rs = st.executeQuery();
            if (!rs.next()) {
                System.out.println("This country does not exist.");
                rs.close();
                st.close();
                return;
            }

            // If country does exist, prompt for new gdp and inflation numbers
            System.out.print("Country per capita gdp (USD): ");
            user_gdp = kb.nextLine();

            System.out.print("Country inflation (pct).....: ");
            user_inflation = kb.nextLine();

            // Create and execute the prepared statement to update table
            String q = "UPDATE Country SET gdp = ?, inflation = ? " +
                            "WHERE country_code = ?";
            st = cn.prepareStatement(q);

            st.setString(1, user_gdp);
            st.setString(2, user_inflation);
            st.setString(3, user_code);
            st.execute();

            // Notify user of the update
            System.out.println("\n" + user_code + "'s gdp and inflation rates have been updated in the CIA Database!");

            this.cn.close();
        }
        catch(SQLException e) {

            System.out.println("updateCountry error occurred");
            e.printStackTrace();
        }       
    }
}