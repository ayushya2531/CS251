<?php
$message = ""; // initial message
if( isset($_POST['admin_data']) ){
    // Includs database connection
    include "db_connect.php";

    // Gets the data from post
    $username = $_POST['username'];
    $password = $_POST['admin_pass'];

    $query = "SELECT * from ADMIN where USERNAME='$username' AND PASSWORD='$password'";
    $result = $db->query($query);
    $data = $result->fetchArray();
    $val = 0;

    if ($data) {
        $query = "SELECT * from USERS";
        $result = $db->query($query);
        $userdata = $result->fetchArray();
        if (!$userdata) {
            $val = 2;
            $message = "USERS table is empty";
        } else {
            $val = 3;
        }
    } else {
        $val = 1;
        $message = "Invalid Username/Password!";
    }
}
?>
<html>
    <head>
        <title>
            Let's Build Stuff!
        </title>

        <link rel="shortcut icon" type="image/png" href="favicon-beer.ico"/>

        <meta charset="utf-8">

        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

        <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container">
            <h2>
                <?php echo $message;?>
            </h2>
            <?php
            if ($val == 1) {
                echo "<h3><a href='admin.php'>See all registrations</a></h3>";
            } else {
                if ($val == 3) {
                    echo '<h3>Data of all Users:</h3>';
                    echo '<div class="table-responsive">';
                    echo '<table class="table table-striped table-hover table-bordered">';
                    echo '<thead>';
                    echo '<tr>';
                    echo '<th>E-Mail</th>';
                    echo '<th>Name</th>';
                    echo '<th>Address</th>';
                    echo '<th>Mobile Number</th>';
                    echo '<th>Account Number</th>';
                    echo '<th>Account Balance</th>';
                    echo '</tr>';
                    echo '</thead>';
                    echo '<tbody>';
                    do {
                        echo '<tr>';
                        echo '<td>';
                        echo $userdata[0];
                        echo '</td>';
                        echo '<td>';
                        echo $userdata[1];
                        echo '</td>';
                        echo '<td>';
                        echo $userdata[2];
                        echo '</td>';
                        echo '<td>';
                        echo $userdata[3];
                        echo '</td>';
                        echo '<td>';
                        echo $userdata[4];
                        echo '</td>';
                        echo '<td>';
                        $q1 = "SELECT * from BANK where ACCNO like '".$userdata[4]."'";
                        $r1 = $db->query($q1);
                        $amt = $r1->fetchArray();
                        echo $amt[1];
                        echo '</td>';
                        echo '</tr>';
                    } while ($userdata = $result->fetchArray());
                    echo '</tbody>';
                    echo '</table>';
                }
            }
            ?>
            <h3>
                <a href="index.php">
                    Another Registration?
                </a>
            </h3>
        </div>
    </body>
</html>
