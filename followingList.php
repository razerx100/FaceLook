<!DOCTYPE html>
<html>
    <head>
        <title>
            <?php
                session_start();

                if(isset($_SESSION['logged_user']))
                    echo $_SESSION['logged_user'];
                else
                    echo "User";
            ?>
        </title>
        <link rel="stylesheet" href="style.css">
        <script type="text/javascript" src="scripts.js"></script>
    </head>
    <body>
        <div class="Header">
            <h1>
                <a class="no_ul" href="/">FaceLook</a>
                <span class="h_links">
                <?php if(isset($_SESSION['logged_user']))
                                echo '
                                        <form class="label" method="GET" action="/userList.php">
                                            <input class="btn" type="submit" value="Users List">
                                        </form>
                                        <form class="label" method="POST" action="/manageUser.php" name="setUserForm">
                                            <input type="hidden" name="setUser" value="'.$_SESSION['logged_user'].'">
                                            <input class="btn" type="submit" value="'.$_SESSION['logged_user'].'">
                                        </form>
                                        <form class="label" method="POST" action="/user.php" name="signOutForm"
                                            onsubmit="return popupConfirm(\'Do you really wanna sign out?\');">
                                            <input type="hidden" name="valuu" value="111">
                                            <input class="btn" type="submit" value="Logout">
                                        </form>';
                ?>
                </span>
            </h1>
        </div>
        <div class="Body">
            <h2>Following </h2> <hr>
            <?php
                $servername = "localhost";
                $username = "razerx100";
                $password = "";
                $dbname = "faceLook";

                if(isset($_SESSION['removedMessage'])){
                    echo "<p>".$_SESSION['removedMessage']."</p>";
                    unset($_SESSION['removedMessage']);
                }

                $connection = new mysqli($servername, $username, $password, $dbname);

                $read_sql = "SELECT following FROM ".$_SESSION['logged_user']." ORDER BY following";

                $result = $connection->query($read_sql);
                if($result->num_rows > 0){
                    while($row = $result->fetch_assoc()){
                        echo '<form class="label" method="POST" action="/manageUser.php">
                                            <input type="hidden" name="setUser" value="'.$row['following'].'">
                                            <input class="btn_body" type="submit" value="'.$row['following'].'">
                                        </form>
                                        <form class="h_links" method="POST" action="/manageFollowing.php"
                                        onsubmit="return popupConfirm(\'Do you really want to unfollow this user?\');">
                                            <input type="hidden" name="remove" value="'.$row['following'].'">
                                            <input type="hidden" name="follower" value="'.$_SESSION['logged_user'].'">
                                            <input class="btn_body" type="submit" value="Unfollow">
                                        </form><br>';
                    }
                }

                $connection->close();
            ?>
        </div>
    </body>
</html>