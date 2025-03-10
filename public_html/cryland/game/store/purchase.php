<?php
require_once("../../other/authorization.php");
require_once("../../data/db.php");
$error_code = 0;

try {
    // Validate empty inputs
    if (empty($_POST['item'])) {
        $error_code = 1;
        throw new Exception();
    }
    // Recive data
    $item = $_POST['item'];
    // Make item case-insensitive
    $item = strtolower($item);
    $is_weapon = false;
    // Is item a consumable
    switch ($item) {
        case 'potion': {
                // 5 coins
                if (!is_affordable(5)) {
                    $error_code = 3;
                    throw new Exception();
                }
                $_SESSION['character']['potion']++;
                $sql = "UPDATE characters SET potion = :potion WHERE id = :id";
                $stmt = $pdo->prepare($sql);
                $stmt->bindParam(":potion", $_SESSION['character']['potion']);
                $stmt->bindParam(":id", $_SESSION['character']['id']);
                // Save changes to database
                if (!$stmt->execute()) {
                    $error_code = 4;
                    throw new Exception();
                }
                give_coins(5);
                break;
            }
        case 'scroll': {
                // 20 coins
                if (!is_affordable(20)) {
                    $error_code = 3;
                    throw new Exception();
                }
                $_SESSION['character']['consumable']++;
                $sql = "UPDATE characters SET consumable = :consumable WHERE id = :id";
                $stmt = $pdo->prepare($sql);
                $stmt->bindParam(":consumable", $_SESSION['character']['consumable']);
                $stmt->bindParam(":id", $_SESSION['character']['id']);
                // Save changes to database
                if (!$stmt->execute()) {
                    $error_code = 4;
                    throw new Exception();
                }
                give_coins(20);
                break;
            }
        default: {
                // Weapon deal start
                // Prepare SQL statement
                $sql = "SELECT * FROM weapons WHERE name = :item";
                $stmt = $pdo->prepare($sql);
                $stmt->bindParam(":item", $item);
                if (!$stmt->execute()) {
                    $error_code = 4;
                    throw new Exception();
                }
                // Is item a weapon
                $item = $stmt->fetch();
                if (empty($item)) {
                    $error_code = 2;
                    throw new Exception();
                }
                if (!is_affordable($item['price'])) {
                    $error_code = 3;
                    throw new Exception();
                }
                give_coins($item['price']);
                $is_weapon = true;
            }
    }
    // Account the payment
    $sql = "UPDATE characters SET coins = :coins WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(":coins", $_SESSION['character']['coins']);
    $stmt->bindParam(":id", $_SESSION['character']['id']);
    // Save changes to database
    if (!$stmt->execute()) {
        $error_code = 4;
        throw new Exception();
    }
    // Update inventory
    if ($is_weapon) {
        $sql = "INSERT INTO eq (characterid, weaponid) VALUES (:character_id, :weapon_id)";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(":character_id", $_SESSION['character']['id']);
        $stmt->bindParam(":weapon_id", $item['id']);
        // Save changes to database
        if (!$stmt->execute()) {
            $error_code = 4;
            throw new Exception();
        }
    }
    // Redirect to shop
    header("Location: index.php");
} catch (Exception $e) {
    $_SESSION['error'] = get_error_msg($error_code);
    header("Location: index.php");
}
function give_coins($price)
{
    $_SESSION['character']['coins'] -= $price;
}
function is_affordable($price)
{
    if ($_SESSION['character']['coins'] < $price) {
        return false;
    }
    return true;
}
function get_error_msg($error_code)
{
    $message = '';
    switch ($error_code) {
        case 1: {
                $message = "No input given.";
                break;
            }
        case 2: {
                $message = "Store dosen't have such thing.";
                break;
            }
        case 3: {
                $message = "Not enough coins.";
                break;
            }
        case 4: {
                $message = "Database error.";
            }
        default: {
                $message =  "Unknown error.";
                break;
            }
    }
    return $message;
}
