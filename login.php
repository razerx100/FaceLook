<!DOCTYPE html>
<html>
    <head>
        <title>
            Login
        </title>
        <link rel="stylesheet" href="style.css">
        <script type="text/javascript" src="scripts.js"></script>
    </head>
    <body>
        <div class="Header">
            <h1>
                Login
                <span class="h_links">
                    <a class="no_ul" href="/">Homepage</a>
                    <a class="no_ul" href="/signup.php">Sign Up</a>
                </span>
            </h1>
        </div>
        <div class="Body">
            <form method="POST" action="/login.php" name="loginForm" onsubmit="return LoginValidaton();">
                <p class="label">Username</p> <input type="text" name="Username"> <br>
                <p class="label">Password</p> <input type="password" name="Password"> <br>
                <input class="btn_body" type="submit" value="Login">
            </form>
            <p class="label" id="alert">
            <?php
                session_start();

                $servername = "localhost";
                $username = "razerx100";
                $password = "";
                $dbname = "faceLook";

                $connection = new mysqli($servername, $username, $password, $dbname);

                if($_SERVER['REQUEST_METHOD'] === 'POST'){
                    $read_sql = "SELECT username, password FROM User WHERE username = '".trim($_POST["Username"])
                    ."' and password = '".trim($_POST["Password"])."'";

                    $result = $connection->query($read_sql);
                    if($result->num_rows > 0){
                        $_SESSION['logged_user'] = $_POST["Username"];
                        $_SESSION['user'] = $_POST["Username"];
                        header("Location: /user.php", true, 301);
                        $connection->close();
                        exit();
                    }
                    else
                        $_SESSION["alertMessage"] = "Username or password doesn't match. Please, sign up.";

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