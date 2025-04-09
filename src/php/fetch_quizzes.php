<?php
$host = "sql308.infinityfree.com";
$db = "if0_38702591_quiz_list";
$user = "if0_38702591";
$pass = "21093596D3421";
// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection
//$conn = new mysqli("localhost", "root", "", "quiz_list");
$connection = new mysqli($host, $user, $pass, $db);

// Check for connection errors
if ($connection->connect_error) {
    die(json_encode(["error" => "Database connection failed: " . $connection->connect_error]));
}

// Fetch all quizzes
$result = $connection->query("SELECT * FROM quizzes");

$quizzes = [];

while ($row = $result->fetch_assoc()) {
    $quizzes[] = $row;
}

// Set the correct JSON header
header('Content-Type: application/json');
echo json_encode($quizzes);

$connection->close();
?>