<?php
    session_start();
    if($_SERVER['REQUEST_METHOD'] === 'POST'){
        if(isset($_POST['setUser']))
            $_SESSION['user'] = $_POST['setUser'];
        unset($_POST);
        header("Location: /user.php", true, 301);
        exit();
    }
    header("Location: ".$_SERVER['HTTP_REFERER'], true, 301);
?>