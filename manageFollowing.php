<?php
    $servername = "localhost";
    $username = "razerx100";
    $password = "";
    $dbname = "faceLook";

    $connection = new mysqli($servername, $username, $password, $dbname);
    session_start();

    if($_SERVER['REQUEST_METHOD'] === 'POST'){
        if(isset($_POST['following'])){
            $read_sql = "SELECT following FROM ".$_POST['follower']." WHERE following = '".trim($_POST['following'])."'";

            $result = $connection->query($read_sql);
            if($result->num_rows == 0){
                $write_sql = "INSERT INTO ".$_POST['follower']."(following) VALUES('"
                                .$_POST["following"]."')";

                $connection->query($write_sql);

                $_SESSION['addedMessage'] = $_POST['following']." has been added.";
            }
            else
                $_SESSION['addedMessage'] = "Already following.";

            unset($_POST);
            header("Location: /userList.php", true, 301);
            $connection->close();
            exit();
        }

        if(isset($_POST['remove'])){
            $remove_sql = "DELETE FROM ".$_POST['follower']." WHERE following = '".$_POST['remove']."'";

            $connection->query($remove_sql);

            $_SESSION['removedMessage'] = "You are not following ".$_POST['remove']." anymore.";

            unset($_POST);
            header("Location: /followingList.php", true, 301);
            $connection->close();
            exit();
        }
    }
    header("Location: ".$_SERVER['HTTP_REFERER'], true, 301);
    $connection->close();
?>