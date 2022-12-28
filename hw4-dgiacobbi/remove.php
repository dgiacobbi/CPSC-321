<!---------------------------------------------------------------------
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/25/22
 * HOMEWORK: #4
 * DESCRIPTION: This file runs the query to remove country from the database 
                as well as notifies the user the country has been removed
                the screen.
 ---------------------------------------------------------------------->

<html>
    <body>
    <h1> CIA Country Information </h1>
    <hr>
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

        <?php
            // get the country name from the form
            $name = $_POST["CountryRemove"];

            // notify user of deletion
            echo "<i>The country with the code '" . $name . "' was successfully removed.</i>";

            // set a prepared statement
            $q = "DELETE FROM Country WHERE country_code = ?";
            $st = $cn->stmt_init();
            $st->prepare($q);
            $st->bind_param("s", $name);

            // execute query
            $st->execute();

            $st->close();
            $cn->close();
        ?>
    
    <p><button onclick="window.location='country.php';">Go Back</button></p>

    </body>
</html>
