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
                                        <form class="label" method="GET" action="/followingList.php">
                                            <input class="btn" type="submit" value="Following">
                                        </form>
                                        <form class="label" method="POST" action="/manageUser.php" name="setUserForm">
                                            <input type="hidden" name="setUser" value="'.$_SESSION['logged_user'].'">
                                            <input class="btn" type="submit" value="'.$_SESSION['logged_user'].'">
                                        </form>
                                        <form class="label" method="POST" action="/user.php"
                                            onsubmit="return popupConfirm(\'Do you really wanna sign out?\');">
                                            <input type="hidden" name="valuu" value="111">
                                            <input class="btn" type="submit" value="Logout">
                                        </form>';
                ?>
                </span>
            </h1>
        </div>
        <div class="Body">
            <p>Welcome
            <?php
                if(isset($_POST["valuu"])){
                    if(isset($_SESSION['logged_user'])){
                        unset($_SESSION['logged_user']);
                        unset($_SESSION['user']);
                    }
                    header("Location: /", true, 301);
                    exit();
                }
                if(isset($_SESSION['logged_user'])){
                    echo " ".$_SESSION['logged_user'];
                }
                else
                    echo " User";
            ?>
            .</p>
            <?php
                $servername = "localhost";
                $username = "razerx100";
                $password = "";
                $dbname = "faceLook";

                $connection = new mysqli($servername, $username, $password, $dbname);

                if(isset($_SESSION['logged_user']) and $_SESSION['user'] === $_SESSION['logged_user']){
                    echo '<form method="POST" action="/user.php" name="blogForm" onsubmit="return PostValidaton();">
                        <textarea name="blogInput" rows="3" cols="40" placeholder="What\'s on your mind?"></textarea>
                        <input type="submit" value="Post">
                    </form>';
                }

                if($_SERVER['REQUEST_METHOD'] === 'POST'){
                    if(isset($_POST["blogInput"])){
                        $write_sql = "INSERT INTO Post(description, username) VALUES('"
                            .$_POST["blogInput"]."', '".$_SESSION['logged_user']."')";

                        $connection->query($write_sql);
                    }

                    if(isset($_POST["deletePost_id"])){
                        $delete_sql = "DELETE FROM Post where id = '".$_POST['deletePost_id']."'";

                        $connection->query($delete_sql);
                    }

                    if(isset($_POST["editPost_desc"])){
                        $update_sql = 'UPDATE Post SET description = "'.$_POST["editPost_desc"].'"
                        WHERE id ="'.$_POST["editPost_id"].'"';

                        $connection->query($update_sql);
                    }

                    unset($_POST);
                    header("Location: ".$_SERVER['PHP_SELF'], true, 301);
                    $connection->close();
                    exit();
                }

                if(isset($_SESSION['user'])){
                    $read_sql = "SELECT id, description, date, username FROM Post WHERE username = '".trim($_SESSION["user"])."'";

                    if($_SESSION['user'] === $_SESSION['logged_user']){
                        $getFollowing_sql = "SELECT following FROM ".$_SESSION["user"];


                        $result = $connection->query($getFollowing_sql);
                        if($result->num_rows > 0){
                            while($row = $result->fetch_assoc())
                                $read_sql = $read_sql." OR username = '".trim($row["following"])."'";
                        }
                    }

                    $read_sql = $read_sql." ORDER BY date";

                    $result = $connection->query($read_sql);
                    if($result->num_rows > 0){
                        while($row = $result->fetch_assoc()){
                            echo '<h4>'.$row["username"].'</h4>
                            <p id="p_'.$row["id"].'">'.$row["description"].'</p><p class="label"> Posted on '.$row["date"].'</p>';

                            if($_SESSION['user'] === $_SESSION['logged_user'] and $_SESSION['user'] === $row['username']){
                                echo '<span class="h_links">
                                            <form class="label" id="editForm_'.$row["id"].'" method="POST"
                                                action="/user.php" onsubmit="return EditCheck('.$row["id"].');">

                                                <input type="hidden" name="editPost_desc" value=0>
                                                <input type="hidden" name="editPost_id" value="'.$row["id"].'">
                                                <input class="btn_body" type="submit" value="Edit">
                                            </form>
                                            <form class="label" method="POST" action="/user.php"
                                            onsubmit="return popupConfirm(\'Do you really wanna delete this post?\');">
                                                <input type="hidden" name="deletePost_id" value="'.$row["id"].'">
                                                <input class="btn_body" type="submit" value="Delete">
                                            </form>
                                        </span>';
                            }
                            echo "<hr>";
                        }
                    }
                }
                else
                    echo "<p>Login onegai.</p>";
                $connection->close();
            ?>
        </div>
    </body>
</html>