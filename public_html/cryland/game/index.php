<?php
// Authorization
require_once("../other/authorization.php");
unset($_SESSION['boss_fight']);
?>

<!-- HTML -->
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title> Game </title>
    <link rel="stylesheet" href="../styles/style.css">
    <link rel="stylesheet" href="../styles/game.css">
</head>

<body>
    <!-- Navigation bar -->
    <?php include_once("../other/navbar.php"); ?>
    <!-- Main menu -->
    <div class="main-window">
        <h2> Home </h2>
        <p> Your character is at home in the village. Decide what to do next. </p>
        <div class="options">
            <button onclick="window.location.href='world/index.php'">
                Explore the Forest</button>
            <button onclick="window.location.href='character/index.php'">
                Manage Character</button>
            <button onclick="window.location.href='inn_controller.php'">
                Visit Local Inn</button>
            <button onclick="window.location.href='store/index.php'">
                Visit General Store</button>
            <!-- Show button for boss duel conditionally -->
            <?php require_once("./game_controller.php"); ?>
        </div>
    </div>
</body>

</html>