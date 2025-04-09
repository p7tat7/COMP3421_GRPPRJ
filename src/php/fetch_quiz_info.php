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

$quiz_id = isset($_GET['id']) ? intval($_GET['id']) : 0;

if ($quiz_id === 0){
    die(json_encode(["error" => "Invalid quiz ID"]));
}

$quiz_query = $connection->prepare("SELECT * FROM quizzes WHERE quiz_id = ?");
$quiz_query->bind_param("i", $quiz_id);
$quiz_query->execute();
$quiz_result = $quiz_query->get_result();
$quiz = $quiz_result->fetch_assoc();

if (!$quiz) {
    die(json_encode(["error" => "Quiz not found"]));
}

header('Content-Type: application/json');
echo json_encode(["quiz" => $quiz]);

$connection->close();
?>