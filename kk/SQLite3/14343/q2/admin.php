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
                Admin Login
            </h1>
            <br>
            <form class="form-horizontal" action="admin_view.php" method="post">
                <div class="form-group">
                    <label class="control-label col-sm-2" for="username">
                        Username:
                    </label>
                    <div class="col-sm-4">
                        <input
                            class="form-control"
                            type="text"
                            name="username"
                            id="username"
                            required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2" for="admin_pass">
                        Password:
                    </label>
                    <div class="col-sm-4">
                        <input
                            class="form-control"
                            type="password"
                            name="admin_pass"
                            id="admin_pass"
                            required>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" name="admin_data" class="btn btn-default" value="Submit">
                    </div>
                </div>
            </form>
            <h4>
                <a href="index.php">Another Registration?</a>
            </h4>
        </div>
    </body>
</html>
