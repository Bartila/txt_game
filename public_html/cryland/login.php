<?php
session_start();
try {
    // Db configuration
    require_once("data/db.php");

    // Check for missing data
    foreach ($_POST as $key => $value) {
        if (empty($value)) {
            throw new Exception();
        }
    }
    // Retrive data
    $email = $_POST['email'];
    $pass = $_POST['password'];

    // Prepare SQL statement
    $sql = "SELECT * FROM users WHERE email = :email";
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(":email", $email);

    // Execute and check for DB errors
    if (!$stmt->execute()) {
        throw new Exception();
    }
    // Check if results are empty
    $result = $stmt->fetch();
    if (empty($result)) {
        throw new Exception();
    }

    // Match password
    if (password_verify($pass, $result["password"])) {
        // Create new session ID for user
        $_SESSION["logged_in"] = true;
        $_SESSION["user_id"] = $result["id"];
        $_SESSION["char_id"] = $result["charactersid"];
        $_SESSION["role_id"] = $result["roleid"];
        header("Location: /account/index.php");
    } else {
        throw new Exception();
    }
} catch (Exception) {
    $_SESSION["error"] = "Wrong email or password.";
    header("Location: index.php");
}
