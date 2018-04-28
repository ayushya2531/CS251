<?php
$message = ""; // initial message
if( isset($_POST['data']) ){
    // Includs database connection
    include "db_connect.php";

    // Gets the data from post
    $name = $_POST['name'];
    $address = $_POST['address'];
    $email = $_POST['email'];
    $mobile = $_POST['mobile'];
    $acc_no = $_POST['acc_no'];
    $bank_pass = $_POST['bank_pass'];

    $query = "SELECT * from BANK where ACCNO='$acc_no' AND PASSWORD='$bank_pass'";
    $result = $db->query($query);
    $data = $result->fetchArray();

    if ($data) {
        $t = $data[1] - 1000.0;
        if ($t < 0) {
            $message = "Insufficient Balance";
        } else {
            $query = "SELECT * from USERS where EMAIL like '".$email."'";
            $result = $db->query($query);
            $data = $result->fetchArray();

            if (!$data) {
                $query = "INSERT INTO USERS VALUES ('$email', '$name', '$address', '$mobile', '$acc_no', '$bank_pass')";
                $db->query($query);

                $query = "UPDATE BANK SET BALANCE='$t' where ACCNO='$acc_no' AND PASSWORD='$bank_pass'";
                $db->query($query);

                $message = "Registration Successful";
            } else {
                $message = "Already registered";
            }
        }
    } else {
        $message = "Invalid Account/Password!";
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
            <h3>
            <a href="index.php">
                Another Registration?
            </a>
            </h3>
        </div>
    </body>
</html>
