
<?php
$host = "sql308.infinityfree.com";
$db = "if0_38702591_quiz_list";
$user = "if0_38702591";
$pass = "21093596D3421";
header("Content-Type: application/json");

// Database connection
//$conn = new mysqli("localhost", "root", "", "quiz_list");
$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "DB connection failed"]);
    exit;
}

// Get JSON POST body
$data = json_decode(file_get_contents("php://input"), true);
//$quizId = intval($data['id']) ?? 0;
$userAnswers = $data["answers"] ?? [];

$score = 0;
$total = count($userAnswers);
$correctAnswers = [];

// Check each answer
foreach ($userAnswers as $entry) {
    $question_id = intval($entry["question_id"]);
    $selected_answer_id = intval($entry["selected_answer_id"]);

    // Fetch correct answer from DB
    $stmt = $conn->prepare("SELECT id FROM answers WHERE question_id = ? AND is_correct = 1");
    $stmt->bind_param("i", $question_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        $correct_answer_id = $row["id"];
        if ($row["id"] == $selected_answer_id) {
            $score++;
        }

        $correctAnswers[] = [
            "question_id" => $question_id,
            "selected_answer_id" => $selected_answer_id,
            "correct_answer_id" => $correct_answer_id
        ];
    }
    $stmt->close();
}

echo json_encode([
    "score" => $score,
    "total" => $total,
    "correctAnswers" => $correctAnswers,
]);
$conn->close();
?>
