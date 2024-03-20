<?php
require_once("../data/db.php");
require_once("../other/authorization.php");
require_once("admin_verification.php");


// Variables to hold the input values
$name = $lvl = $attack = $health = $defense = "";

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get and sanitize form input
    $name = cleanInput($_POST["name"]);
    $lvl = cleanInput($_POST["lvl"]);
    $attack = cleanInput($_POST["attack"]);
    $health = cleanInput($_POST["health"]);
    $defense = cleanInput($_POST["defense"]);

    // Validate input
    if (empty($name) || $lvl < 0 || $attack < 0 || $health < 0 || $defense < 0) {
        $_SESSION['error'] = "Please enter valid values. Negative values are not allowed.";
        header("Location: index.php");
    } else {
        try {
            // Prepare the SQL statement to insert data
            $stmt = $pdo->prepare("INSERT INTO enemies (name, lvl, attack, health, maxhealth, defense) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([$name, $lvl, $attack, $health, $health, $defense]);
            // Redirect to the enemies table view after adding the record
            $_SESSION['success'] = "$name added into enemies";
            header("Location: index.php");
            exit();
        } catch (PDOException $e) {
            $_SESSION['error'] = "Error: " . $e->getMessage();

        }
    }
}

// Function to sanitize form input
function cleanInput($data) {
    return htmlspecialchars(trim($data));
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Enemy</title>
    <!-- Add your CSS styles here -->
    <style>
        /* Your CSS styles for the form */
    </style>
</head>
<body>
<h2>Add Enemy</h2>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="<?php echo $name; ?>"><br><br>

    <label for="lvl">Level:</label>
    <input type="number" id="lvl" name="lvl" value="<?php echo $lvl; ?>" min="1"><br><br>

    <label for="attack">Attack:</label>
    <input type="number" id="attack" name="attack" value="<?php echo $attack; ?>" min="1"><br><br>

    <label for="health">Health:</label>
    <input type="number" id="health" name="health" value="<?php echo $health; ?>" min="1"><br><br>

    <label for="defense">Defense:</label>
    <input type="number" id="defense" name="defense" value="<?php echo $defense; ?>" min="0"><br><br>

    <input type="submit" value="Add Enemy">
</form>
<button onclick="showTable('enemies');">Go back</button>
</body>
</html>