
let timeLeft = 0;
let timerInterval;
let quiz_title = "";
let quizId = -1;
let max_score = -1;

// Fetch quiz's information
document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    quizId = urlParams.get("id");
    if (!quizId){
        document.body.innerHTML = "<h1>Invalid Quiz</h1>";
        return;
    }
    fetch(`../php/fetch_quiz_info.php?id=${quizId}`)
        .then(response => response.json()) // Convert response to JSON
        .then(data => {
            max_score = data.quiz.max_score;
            const quizContainer = document.getElementById("quiz-container");
            quizContainer.innerHTML = ""; // Clear previous content

            if (data.error){
                const alert = document.createElement("div");
                alert.classList.add("quiz_error");
                alert.innerHTML = `<p>Could not get the information about the quiz. ${data.error}</p>`;
                quizContainer.appendChild(alert);
                return;
            }

            timeLeft = data.quiz.time_set * 60;
            quiz_title = data.quiz.title;
            const info = document.createElement("div");
            info.classList.add("info");
            info.innerHTML = `
                <p class="quiz-title">${data.quiz.title}</p>
                <div class="sub-container">
                    <p class="time-content">Time Limit: ${String(Math.floor(timeLeft/60)).padStart(2, '0')}:${String(timeLeft%60).padStart(2, '0')}</p>
                    <p class="score-content">Max Score: ${data.quiz.max_score}</p>
                </div>

                <p class="quiz-description">${data.quiz.description}</p>
            `
            const start_btn = document.createElement("button");
            start_btn.classList.add("btn");
            start_btn.addEventListener("click", function(){animateContentUpdate(startQuiz)});
            start_btn.innerHTML = "Start";

            
            quizContainer.appendChild(info);
            quizContainer.appendChild(start_btn);
        })
        .catch(error => console.error("Error fetching quizzes:", error));
});

// Fetch the questions of the quiz and start the quiz
async function startQuiz() {
    await fetch(`../php/fetch_questions.php?id=${quizId}`)
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

        const result_display = document.createElement("div");
        result_display.classList.add("hidden");
        result_display.id = "result-field";

        quizContainer.appendChild(info);
        quizContainer.appendChild(result_display);

        const questionsContainer = document.createElement("form");
        questionsContainer.classList.add("question-container");
        questionsContainer.innerHTML = "";

        let data_questions = data.questions;
        shuffle(data_questions);

        data_questions.forEach((q, index) => {
            const questionDiv = document.createElement("div");
            questionDiv.classList.add("question");
            questionDiv.setAttribute("data-question-id", q.question_id);

            let answersHtml = "";
            let shuffled_answers = q.answers;
            shuffle(shuffled_answers);
            shuffled_answers.forEach(answer => {
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

        questionsContainer.addEventListener("submit", function(e){
            e.preventDefault();
            submitQuiz(e);
        });

        
        const submit_btn = document.createElement("button");
        submit_btn.id = "submit-btn"
        submit_btn.classList.add("btn");
        submit_btn.type = "submit";
        submit_btn.innerHTML = "Submit";
        questionsContainer.appendChild(submit_btn);
        //submit_btn.addEventListener("click", endQuiz);
        quizContainer.appendChild(questionsContainer);
        
        // Start timer
        document.getElementById("time-left").textContent = `${String(Math.floor(timeLeft/60)).padStart(2, '0')}:${String(timeLeft%60).padStart(2, '0')}`;
        document.getElementById("timer").classList.remove("hidden");

        startTimer();
    })
    .catch(error => console.error("Error fetching quizzes:", error));
    
    
}

function startTimer(){
    timerInterval = setInterval(() => {
        timeLeft--;
        let minute = Math.floor(timeLeft/60);
        let second = timeLeft % 60;
        document.getElementById("time-left").textContent = `${String(minute).padStart(2, '0')}:${String(second).padStart(2, '0')}`;
        if (timeLeft <= 0) {
            clearInterval(timerInterval);
            animateContentUpdate(endQuiz);
        }
    }, 1000);
}

function submitQuiz(e){
    //e.preventDefault();

    const answers = [];
    let firstUnanswered = null;
    document.querySelectorAll(".question").forEach(question =>{
        const questionId = question.dataset.questionId;
        const selected = question.querySelector(`input[name="question_${questionId}"]:checked`);
        if (selected){
            question.classList.remove("unanswered");
            answers.push({
                question_id: questionId,
                selected_answer_id: selected.value
            });
        } else if (!firstUnanswered){
            firstUnanswered = question;
        }
    });

    if (firstUnanswered){
        firstUnanswered.scrollIntoView({ behavior: "smooth", block: "center" });
        firstUnanswered.classList.add("unanswered");
        //alert("Please answer all questions before submitting.");
        return;
    }
    clearInterval(timerInterval);
    document.getElementById("timer").classList.add("hidden");
    document.getElementById("submit-btn").classList.add("hidden");
    animateContentUpdate(() => checkAnswers(answers));
    window.scrollTo({ top: 0, behavior: 'smooth' });

    
}

async function checkAnswers(answers){
    await fetch("../php/check_answers.php", {
        method: "POST",
        headers:{
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ answers })
    })
    .then(res => res.json())
    .then(data => {
        const resultBox = document.getElementById("result-field");
        resultBox.textContent = `Total: ${Math.floor(data.score/data.total*max_score)} / ${max_score}`;
        resultBox.classList.remove("hidden");

        document.querySelectorAll("input[type='radio']").forEach(radio => {
            radio.disabled = true;
        });
        
        document.querySelectorAll(".question.unanswered").forEach(q => {
            q.classList.remove("unanswered");
        });

        data.correctAnswers.forEach(correct => {
            const questionId = correct.question_id;
            const correctId = correct.correct_answer_id;
            const selectedId = correct.selected_answer_id;

            const options = document.querySelectorAll(`input[name="question_${questionId}"]`);

            options.forEach(input => {
                const label = input.parentElement;
                if (parseFloat(input.value) === correctId) {
                    label.classList.add("correct");
                } else if (input.checked && parseInt(input.value) !== correctId){
                    label.classList.add("wrong");
                }
            });
        });
    })
    .catch(err => {
        console.error("Submission Error: ", err);
    });

}

// End the quiz
async function endQuiz(){
    clearInterval(timerInterval);
    document.getElementById("timer").classList.add("hidden");
    document.getElementById("submit-btn").classList.add("hidden");

    const answers = [];
    let unanswered = [];
    document.querySelectorAll(".question").forEach(question =>{
        const questionId = question.dataset.questionId;
        const selected = question.querySelector(`input[name="question_${questionId}"]:checked`);
        if (selected){
            answers.push({
                question_id: questionId,
                selected_answer_id: selected.value
            });
        } else {
            unanswered.push(question);
            answers.push({
                question_id: questionId,
                selected_answer_id: -1
            });
        }
    });

    Swal.fire({
        icon: 'warning',
        title: '⏰ Time’s Up!',
        text: 'Your quiz is being submitted automatically.',
        confirmButtonText: 'OK',
        allowOutsideClick: false,
    }).then(() => {
        checkAnswers(answers);
        unanswered.forEach(ans => {
            ans.classList.add("no-answer");
        });
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

}

function shuffle(array) {
    let currentIndex = array.length;

    while (currentIndex != 0) {

        let randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex--;

        [array[currentIndex], array[randomIndex]] = [
        array[randomIndex], array[currentIndex]];
    }
}

async function animateContentUpdate(updateFunction) {
    const container = document.getElementById("quiz-container");

    container.classList.add('animate__animated', 'animate__fadeOut');

    container.addEventListener('animationend', async function handler() {
        
        container.removeEventListener('animationend', handler);
        if (typeof updateFunction === "function") {
            await updateFunction();
        }
        container.classList.remove('animate__fadeOut');
        container.classList.add('animate__fadeIn');

        container.addEventListener('animationend', function innerHandler() {
            container.classList.remove('animate__animated', 'animate__fadeIn');
            container.removeEventListener('animationend', innerHandler);
        });

    });
}

