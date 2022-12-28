<!---------------------------------------------------------------------
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/25/22
 * HOMEWORK: #4
 * DESCRIPTION: This file is the landing page for the DB application.
 ---------------------------------------------------------------------->

<html>
    <body>
        <!-- Header Title -->
        <h1> CIA Country Information </h1>
        <hr>

        <!-- Connect to Database -->
        <?php
            // connection params
            $config = parse_ini_file ("../hw4-dgiacobbi/config.ini");
            $server = $config ["servername"];
            $username = $config ["username"];
            $password = $config ["password"];
            $database = "dgiacobbi_DB";
            
            // connect to db
            $cn = mysqli_connect ($server, $username, $password, $database);

            // check connection
            if (!$cn) {
                die("Connection failed: " . mysqli_connect_error());
            }
        ?>

        <!-- Add Coutry Table w/ text inputs -->
        <h4> Add country: <h4>
        <form action="insert.php" method="POST">
            <table>
                <tr>
                    <td>Country Code:</td>
                    <td><input type="text" name="code"></td>
                </tr>
                <tr>
                    <td>Country Name:</td>
                    <td><input type="text" name="name"></td>
                </tr>
                <tr>
                    <td>Country GDP:</td>
                    <td><input type="text" name="gdp"></td>
                </tr>
                <tr>
                    <td>Country Inflation:</td>
                    <td><input type="text" name="inflation"></td>
                </tr>
            </table>
            <input type='submit' value='Add'/>
        </form>   

        <!-- Display Country with dynamic list -->
        <h4> Display country information: </h4>
        <form action="display.php" method="POST">
            <select name="CountryDisplay">

                <!-- Query to dynamically collect list of current countries in DB -->
                <?php    
                    $q = "SELECT * FROM Country";
                    $rs = mysqli_query($cn, $q);

                    if (mysqli_num_rows($rs) > 0) {
                        while($row = mysqli_fetch_assoc($rs)) {
                            echo "<option value = ". $row["country_code"]
                                 . ">" . $row["country_name"] . "</option>";
                        }
                    }
                ?>
            </select>
            <input type="submit" value="Display"/>
        </form>

        <!-- Update country info given user input and country selection -->
        <h4> Update country information: <h4>
        <form action="update.php" method="POST">        
            <table>
                <tr>
                    <td>Country:</td>
                    <td>
                        <select name="CountryUpdate">
                            <!-- Query to find current countries in DB -->
                            <?php    
                                $q = "SELECT * FROM Country";
                                $rs = mysqli_query($cn, $q);

                                if (mysqli_num_rows($rs) > 0) {
                                    while($row = mysqli_fetch_assoc($rs)) {
                                        echo "<option value = ". $row["country_code"]
                                            . ">" . $row["country_name"] . "</option>";
                                    }
                                }
                            ?>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Country GDP:</td>
                    <td><input type="text" name="gdpUpdate"></td>
                </tr>
                <tr>
                    <td>Country Inflation:</td>
                    <td><input type="text" name="inflationUpdate"></td>
                </tr>
            </table>
            <input type='submit' value='Update'/>
        </form>

        <!-- Remove country from dynamic list -->
        <h4> Remove country: </h4>
        <form action="remove.php" method="POST">
            <select name="CountryRemove">

                <!-- Query used to find current countries in DB -->
                <?php    
                    $q = "SELECT * FROM Country";
                    $rs = mysqli_query($cn, $q);

                    if (mysqli_num_rows($rs) > 0) {
                        while($row = mysqli_fetch_assoc($rs)) {
                            echo "<option value = ". $row["country_code"] 
                                 . ">" . $row["country_name"] . "</option>";
                        }
                    }
                ?>
            </select>
            <input type='submit' value='Remove'/>
        </form>

    </body>
</html>