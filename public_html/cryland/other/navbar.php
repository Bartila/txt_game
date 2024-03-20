<head>
    <link rel="stylesheet" href="/styles/navbar.css">
    <style>
        .flex-container {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>

<?php

if ($_SESSION['logged_in'] && $_SESSION['role_id'] == 2) {
    echo '<!-- Navigation bar -->
    <div class="navbar">
        <div class="flex-container">
            <div>
                <a href="/game">Home</a>
                <a href="/ranking">Ranking</a>
            </div>
            <div>
                <a href="/admin">Admin Panel</a>
                <a href="/account">Account</a>
                <a class="logout" href="/other/logout.php">Logout</a>
            </div>
        </div>
    </div>
        ';
} elseif ($_SESSION['logged_in']) {
    echo '<!-- Navigation bar -->
    <div class="navbar">
        <div class="flex-container">
            <div>
                <a href="/game">Home</a>
                <a href="/ranking">Ranking</a>
            </div>
            <div>
                <a href="/account">Account</a>
                <a class="logout" href="/other/logout.php">Logout</a>
            </div>
        </div>
    </div>
        ';
} else {
    echo '<!-- Navigation bar -->
    <div class="navbar">
        <div class="flex-container">
            <div>
                <a href="../">Home</a>
                <a href="/ranking">Ranking</a>
            </div>
            <div>
                <a href="/register">Register</a>
                <a href="../">Log in</a>
            </div>
        </div>
    </div>';
}
?>