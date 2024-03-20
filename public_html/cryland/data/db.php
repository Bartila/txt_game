<?php
// Db configuration
$host = "mysql";
$dbname = "exampledb";
$username = "root";
$password = "root";
$dsn = "mysql:host=" . $host . ";dbname=" . $dbname;


// Create PDO in stance
$pdo = new PDO($dsn, $username, $password);
?>