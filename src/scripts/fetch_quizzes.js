
document.addEventListener("DOMContentLoaded", function () {
fetch("../php/fetch_quizzes.php")
    .then(response => response.json()) // Convert response to JSON
    .then(data => {
        const quizContainer = document.getElementById("quiz-layout");
        quizContainer.innerHTML = ""; // Clear previous content

        if (data.length == 0){
            const alert = document.createElement("div");
            alert.classList.add("noquiz_message");
            alert.innerHTML = `<p>There is no quizzes right now. </p>`;
            quizContainer.appendChild(alert);
            return;
        }

        data.forEach(quiz => {
            const quizItem = document.createElement("div");
            quizItem.classList.add("quiz-container");
            quizItem.innerHTML = `
                <div class="quiz-header">
                    <p class="quiz-title">
                        ${quiz.title}
                    </p>
                    <div class="time-content">
                        <p>Time: </p>
                        <p class="time">${String(quiz.time_set).padStart(2, '0')}:00</p>
                    </div>
                </div>

                <div class="quiz-description">
                    <p class="description-content">
                        ${quiz.description}
                    </p>
                </div>

                <div class="quiz-footer">
                    <div class="fullmark-container">
                        <p class="fullmark-content">
                            Full Mark:
                        <p class="fullmark">${quiz.max_score}</p>
                        </p>
                    </div>
                </div>
            `;
            quizItem.addEventListener("click", function (){
                window.location.href = `quizpage.html?id=${quiz.quiz_id}`
            });
            quizContainer.appendChild(quizItem);
        });
    })
    .catch(error => console.error("Error fetching quizzes:", error));
});
