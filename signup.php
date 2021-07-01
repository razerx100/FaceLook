<!DOCTYPE html>
<html>
    <head>
        <title>
            Sign Up
        </title>
        <link rel="stylesheet" href="style.css">
        <script type="text/javascript" src="scripts.js"></script>
    </head>
    <body>
        <div class="Header">
            <h1>
                Sign Up
                <span class="h_links">
                    <a class="no_ul" href="/">Homepage</a>
                    <a class="no_ul" href="/login.php">Login</a>
                </span>
            </h1>
        </div>
        <div class="Body">
            <form method="POST" action="/signup.php" name="signUpForm" onsubmit="return SignUpValidaton();">
                <p class="label">First Name</p> <input type="text" name="Firstname"> <br>
                <p class="label">Last Name</p> <input type="text" name="Lastname"> <br>
                <p class="label">Username</p> <input type="text" name="Username"> <br>
                <p class="label">Password</p> <input type="password" name="Password"> <br>
                <p class="label">Rewrite Password</p> <input type="password" name="Password_Re"> <br>
                <input class="btn_body" type="submit" value="Sign up">
            </form>
            <p class="label" id="alert">
            <?php
                $servername = "localhost";
                $username = "razerx100";
                $password = "";
                $dbname = "faceLook";

                $connection = new mysqli($servername, $username, $password, $dbname);
                session_start();

                if($_SERVER['REQUEST_METHOD'] === 'POST'){
                    $read_sql = "SELECT username FROM User WHERE username = '".trim($_POST["Username"])."'";

                    $result = $connection->query($read_sql);
                    if($result->num_rows == 0){
                        $write_sql = "INSERT INTO User(username, firstname, lastname, password) VALUES('"
                        .$_POST["Username"]."', '".$_POST["Firstname"]."', '"
                        .$_POST["Lastname"]."', '".$_POST["Password"]."')";

                        $connection->query($write_sql);

                        $createTable_sql = 'CREATE TABLE '.$_POST["Username"].' (
                                ID INT NOT NULL AUTO_INCREMENT,
                                following VARCHAR(50),
                                PRIMARY KEY (ID),
                                FOREIGN KEY(following) REFERENCES User(username)
                            )';

                        $connection->query($createTable_sql);
                        $_SESSION["alertMessage"] = "Sign up successful!";
                    }
                    else
                        $_SESSION["alertMessage"] = "Username already exists!";

                    unset($_POST);
                    header("Location: ".$_SERVER['PHP_SELF'], true, 301);
                    $connection->close();
                    exit();
                }

                if(isset($_SESSION["alertMessage"])){
                    echo $_SESSION["alertMessage"];
                    unset($_SESSION["alertMessage"]);
                }

                $connection->close();
            ?>
            </p>
        </div>
    </body>
</html>