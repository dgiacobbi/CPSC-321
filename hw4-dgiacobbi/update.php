<!---------------------------------------------------------------------
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/25/22
 * HOMEWORK: #4
 * DESCRIPTION: This file runs the query to update the database of a 
                specific country as well as displays the new data to 
                the screen.
 ---------------------------------------------------------------------->

<html>
    <body>
    <h1> CIA Country Information </h1>
    <hr>
        <!-- Connect to DB -->
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

        <!-- Runs query and prints results -->
        <?php
            // get the country name from the form
            // get the country name from the form
            $code = $_POST["CountryUpdate"];
            $gdp = $_POST["gdpUpdate"];
            $inflation = $_POST["inflationUpdate"];

            // set a prepared statement
            $q = "UPDATE Country SET gdp = ?, inflation = ? WHERE country_code = ?";
            $st = $cn->stmt_init();
            $st->prepare($q);
            $st->bind_param("ids", $gdp, $inflation, $code);

            // execute query to update DB
            $st->execute();

            // set a prepared statement to print results to screen
            $q = "SELECT * FROM Country WHERE country_code = ?";
            $st = $cn->stmt_init();
            $st->prepare($q);
            $st->bind_param("s", $code);

            // execute query and bind result
            $st->execute();
            $st->bind_result($country_code, $country_name, $gdp, $inflation);

            // prints out country info of updated country
            while($st->fetch()) {  

                echo "<p><i>Update Successful: </i></p>";
                echo "<li>Country code: <strong>" . $country_code . "</strong></li>";
                echo "<li>Country name: <strong>" . $country_name . "</strong></li>";
                echo "<li>Country GDP: <strong>$" . $gdp . "</strong></li>";
                echo "<li>Country Inflation: <strong>" . $inflation . "%</strong>";
            }

            $st->close();
            $cn->close();
        ?>
    
    <!-- Return to menu button -->
    <p><button onclick="window.location='country.php';">Go Back</button></p>

    </body>
</html>
