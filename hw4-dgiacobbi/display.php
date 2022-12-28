<!---------------------------------------------------------------------
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/25/22
 * HOMEWORK: #4
 * DESCRIPTION: This file runs the query to display a specific country 
                and its attributes. These are then printed to the screen
                individually.
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

        <!-- Query country info and display to screen -->
        <?php
            // get the country name from the form and store in variable
            $name = $_POST["CountryDisplay"];

            // set a prepared statement
            $q = "SELECT * FROM Country WHERE country_code = ?";
            $st = $cn->stmt_init();
            $st->prepare($q);
            $st->bind_param("s", $name);

            // execute query and bind result
            $st->execute();
            $st->bind_result($country_code, $country_name, $gdp, $inflation);

            // print results to screen
            while($st->fetch()) {  

                echo "<li>Country code: <strong>" . $country_code . "</strong></li>";
                echo "<li>Country name: <strong>" . $country_name . "</strong></li>";
                echo "<li>Country GDP: <strong>$" . $gdp . "</strong></li>";
                echo "<li>Country Inflation: <strong>" . $inflation . "%</strong>";
            }

            $st->close();
            $cn->close();
        ?>

        <!-- Button to return screen -->
        <p><button onclick="window.location='country.php';">Go Back</button></p>

    </body>
</html>