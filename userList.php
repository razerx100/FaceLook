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
                                        <form class="label" method="GET" action="/followingList.php">
                                            <input class="btn" type="submit" value="Following">
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
            <h2>Users </h2> <hr>
            <?php
                $servername = "localhost";
                $username = "razerx100";
                $password = "";
                $dbname = "faceLook";

                $connection = new mysqli($servername, $username, $password, $dbname);

                if(isset($_SESSION['addedMessage'])){
                    echo "<p>".$_SESSION['addedMessage']."</p>";
                    unset($_SESSION['addedMessage']);
                }

                $read_sql = "SELECT username FROM User ORDER BY username";

                $result = $connection->query($read_sql);
                if($result->num_rows > 0){
                    while($row = $result->fetch_assoc()){
                        echo '<form class="label" method="POST" action="/manageUser.php">
                                            <input type="hidden" name="setUser" value="'.$row['username'].'">
                                            <input class="btn_body" type="submit" value="'.$row['username'].'">
                                        </form>';
                        if($row['username'] != $_SESSION['logged_user'])
                            echo '<form class="h_links" method="POST" action="/manageFollowing.php"
                                        onsubmit="return popupConfirm(\'Do you really want to follow this user?\');">
                                            <input type="hidden" name="following" value="'.$row['username'].'">
                                            <input type="hidden" name="follower" value="'.$_SESSION['logged_user'].'">
                                            <input class="btn_body" type="submit" value="Follow">
                                        </form>';
                        echo "<br>";
                    }
                }

                $connection->close();
            ?>
        </div>
    </body>
</html>