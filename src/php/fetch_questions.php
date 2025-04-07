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

$quiz_id = isset($_GET['id']) ? intval($_GET['id']) : 0;

if ($quiz_id === 0){
    die(json_encode(["error" => "Invalid quiz ID"]));
}

$question_query = $connection->prepare("
    SELECT q.id AS question_id, q.question_text, 
           a.id AS answer_id, a.answer_text, a.is_correct 
    FROM questions q 
    JOIN answers a ON q.id = a.question_id 
    WHERE q.quiz_id = ?
");
$question_query->bind_param("i", $quiz_id);
$question_query->execute();
$question_result = $question_query->get_result();
$questions = [];
while ($row = $question_result->fetch_assoc()) {
    $questions[$row['question_id']]['question_id'] = $row['question_id'];
    $questions[$row['question_id']]['question_text'] = $row['question_text'];
    $questions[$row['question_id']]['answers'][] = [
        "answer_id" => $row['answer_id'],
        "answer_text" => $row['answer_text'],
        "is_correct" => $row['is_correct']
    ];
}
$questions = array_values($questions);

header('Content-Type: application/json');
echo json_encode([
    "questions" => $questions
]);

$connection->close();
?>