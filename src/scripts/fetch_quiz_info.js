
document.addEventListener("DOMContentLoaded", function () {
    
    const urlParams = new URLSearchParams(window.location.search);
    const quizId = urlParams.get("id");
    if (!quizId){
        document.body.innerHTML = "<h1>Invalid Quiz</h1>";
        return;
    }
    let timeLeft = 0;
    let timerInterval;
    let quiz_title = "";
    fetch(`../php/fetch_quiz_info.php?id=${quizId}`)
        .then(response => response.json()) // Convert response to JSON
        .then(data => {
            const quizContainer = document.getElementById("quiz-container");
            quizContainer.innerHTML = ""; // Clear previous content

            if (data.error){
                const alert = document.createElement("div");
                alert.classList.add("quiz_error");
                alert.innerHTML = `<p>Could not get the information about the quiz. ${data.error}</p>`;
                quizContainer.appendChild(alert);
                return;
            }

            timeLeft = data.quiz.time_set;
            quiz_title = data.quiz.title;
            const info = document.createElement("div");
            info.classList.add("info");
            info.innerHTML = `
                <p class="quiz-title">${data.quiz.title}</p>
                <div class="sub-container">
                    <p class="time-content">Time Limit: ${data.quiz.time_set}mins</p>
                    <p class="score-content">Max Score: ${data.quiz.max_score}</p>
                </div>

                <p class="quiz-description">${data.quiz.description}</p>
            `
            const start_btn = document.createElement("button");
            start_btn.classList.add("btn");
            start_btn.addEventListener("click", function(){startQuiz()});
            start_btn.innerHTML = "Start";

            quizContainer.appendChild(info);
            quizContainer.appendChild(start_btn);
        })
        .catch(error => console.error("Error fetching quizzes:", error));

    function startQuiz() {
        fetch(`../php/fetch_questions.php?id=${quizId}`)
        .then(response => response.json()) // Convert response to JSON
        .then(data => {
            const quizContainer = document.getElementById("quiz-container");
            quizContainer.innerHTML = ""; // Clear previous content

            if (data.error){
                const alert = document.createElement("div");
                alert.classList.add("quiz_error");
                alert.innerHTML = `<p>Could not questions of the quiz. ${data.error}</p>`;
                quizContainer.appendChild(alert);
                return;
            }
            const info = document.createElement("div");
            info.classList.add("info");
            info.innerHTML = `
                <p class="quiz-title">${quiz_title}</p>
            `

            quizContainer.appendChild(info);

            const questionsContainer = document.createElement("question-container");
            questionsContainer.innerHTML = "";

            data.questions.forEach((q, index) => {
                const questionDiv = document.createElement("div");
                questionDiv.classList.add("questions");

                let answersHtml = "";
                q.answers.forEach(answer => {
                    answersHtml += `
                        <label>
                            <input type="radio" name="question_${q.question_id}" value="${answer.answer_id}">
                            ${answer.answer_text}
                        </label><br>
                    `;
                });

                questionDiv.innerHTML = `
                    <h3>Q${index + 1}: ${q.question_text}</h3>
                    ${answersHtml}
                `;
                questionsContainer.appendChild(questionDiv);
                
            });
            quizContainer.appendChild(questionsContainer);
            const submit_btn = document.createElement("button");
            submit_btn.id = "submit-btn"
            submit_btn.classList.add("btn");
            submit_btn.innerHTML = "Submit";
            submit_btn.addEventListener("click", endQuiz);

            quizContainer.appendChild(submit_btn);
        })
        .catch(error => console.error("Error fetching quizzes:", error));
        
        // Start timer
        document.getElementById("time-left").textContent = timeLeft;
        document.getElementById("timer").classList.remove("hidden");
        timerInterval = setInterval(() => {
            timeLeft--;
            document.getElementById("time-left").textContent = timeLeft;
            if (timeLeft <= 0) {
                clearInterval(timerInterval);
                endQuiz();
            }
        }, 60000);
    }

    function endQuiz(){
        clearInterval(timerInterval);
        document.getElementById("quiz-container").innerHTML = "<h2>Time's up! Quiz Over.</h2>";
    }
});
