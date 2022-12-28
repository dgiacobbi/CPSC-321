<!---------------------------------------------------------------------
 * NAME: David Giacobbi
 * CLASS: CPSC 321-01
 * DATE: 10/25/22
 * HOMEWORK: #4
 * DESCRIPTION: This file runs the query to insert into the database a 
                new country as well as displays the new data to 
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

        <!-- Insert country given user info into DB -->
        <?php
            // get the country name from the form and store into variables
            $code = $_POST["code"];
            $name = $_POST["name"];
            $gdp = $_POST["gdp"];
            $inflation = $_POST["inflation"];

            // notify user of deletion
            echo "<p><i>Country Added Successfully: </i></p>";
            echo "<li>Country code: <strong>" . $code . "</strong></li>";
            echo "<li>Country name: <strong>" . $name . "</strong></li>";
            echo "<li>Country GDP: <strong>$" . $gdp . "</strong></li>";
            echo "<li>Country Inflation: <strong>" . $inflation . "%</strong>";

            // set a prepared statement of insertion
            $q = "INSERT INTO Country VALUES (?, ?, ?, ?)";
            $st = $cn->stmt_init();
            $st->prepare($q);
            $st->bind_param("ssid", $code, $name, $gdp, $inflation);

            // execute query
            $st->execute();

            $st->close();
            $cn->close();
        ?>
    
    <!-- Button to return to menu -->
    <p><button onclick="window.location='country.php';">Go Back</button></p>

    </body>
</html>
