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
            <h1>
                To build or not to build, that is the question
            </h1>
            <br>
            <form class="form-horizontal" action="insert.php" method="post">
                <div class="form-group">
                    <label class="control-label col-sm-2" for="name">
                        Name:
                    </label>
                    <div class="col-sm-4">
                        <input
                            class="form-control"
                            type="text"
                            pattern="[a-zA-Z\s]{1,20}"
                            name="name"
                            id="name"
                            maxlength="20"
                            required
                            title="Name can have upto 20 characters (alphabets + spaces)">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for="address">
                        Address:
                    </label>
                    <div class="col-sm-4">
                        <input
                            class="form-control"
                            type="text"
                            name="address"
                            id="address"
                            maxlength="100"
                            required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for="email">
                        E-mail Address:
                    </label>
                    <div class="col-sm-4">
                        <input
                            class="form-control"
                            type="text"
                            pattern="[a-zA-Z]{1,}@.*\.com"
                            name="email"
                            id="email"
                            required
                            title="Left side of the e-mail can onlt have alphabets. Also e-mail needs to end with a '.com' domain">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for="mobile">
                        Mobile Number:
                    </label>
                    <div class="col-sm-4">
                        <input
                            class="form-control"
                            type="text"
                            pattern="[1-9]{1}[0-9]{9}"
                            name="mobile"
                            id="mobile"
                            maxlength="10"
                            required
                            title="Mobile numbers have exactly 10 digits, with the first digit being non zero">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for="acc_no">
                        Bank Account Number:
                    </label>
                    <div class="col-sm-4">
                        <input
                            class="form-control"
                            type="text"
                            pattern="[0-9]{5}"
                            name="acc_no"
                            id="acc_no"
                            maxlength="5"
                            required
                            title="Bank Account numbers have exactly 5 digits">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for="bank_pass">
                        Bank Password:
                    </label>
                    <div class="col-sm-4">
                        <input
                            class="form-control"
                            type="password"
                            pattern="[a-zA-Z0-9]{1,20}"
                            name="bank_pass"
                            id="bank_pass"
                            maxlength="20"
                            required
                            title="Password can have upto 20 alphanumeric characters">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" name="data" class="btn btn-default" value="Submit">
                    </div>
                </div>
            </form>
            <h4>
                <a href="admin.php">See all registrations</a>
            </h4>
        </div>
    </body>
</html>
