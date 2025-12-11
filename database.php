<?php
$servername = "mariadb";
$username = "cs332g1";
$password = "5hAECEpz";
$dbname = "cs332g1";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
