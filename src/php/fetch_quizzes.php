<?php
// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection
$connection = new mysqli("localhost", "root", "", "quiz_list");

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