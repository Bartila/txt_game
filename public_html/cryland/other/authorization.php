<?php
session_start();
// Check access rights
if (has_no_access()) {
    // Przed ścieżką zawsze: '/'
    header("Location: /index.php");
    exit();
}

function has_no_access()
{
    if(isset($_SESSION["logged_in"])){
        $is_logged = $_SESSION["logged_in"];
    }else $is_logged = false;

    if (empty($is_logged) || $is_logged == false) {
        return true;
    } else {
        return false;
    }
}