-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2025 at 08:21 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
DROP DATABASE IF EXISTS `quiz_list`;
CREATE DATABASE `quiz_list`;
USE `quiz_list`;
--
-- Database: `quiz_list`
--

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer_text` varchar(255) NOT NULL,
  `is_correct` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `answers`
--

INSERT INTO `answers` (`id`, `question_id`, `answer_text`, `is_correct`) VALUES
(1, 1, 'Berlin', 0),
(2, 1, 'Madrid', 0),
(3, 1, '(Correct) Paris ', 1),
(4, 1, 'Rome', 0),
(5, 2, 'Venus', 0),
(6, 2, '(Correct) Mars', 1),
(7, 2, 'Jupiter', 0),
(8, 2, 'Jupiter', 0),
(9, 3, 'Atlantic', 0),
(10, 3, 'Indian', 0),
(11, 3, 'Arctic', 0),
(12, 3, '(Correct) Pacific', 1),
(13, 4, 'Vincent van Gogh', 0),
(14, 4, 'Pablo Picasso', 0),
(15, 4, '(Correct) Leonardo da Vinci', 1),
(16, 4, 'Michelangelo', 0),
(17, 5, 'Brazil', 0),
(18, 5, 'South Africa', 0),
(19, 5, '(Correct) Australia', 1),
(20, 5, 'New Zealand', 0),
(21, 6, 'Won', 0),
(22, 6, '(Correct) Yen', 1),
(23, 6, 'Dollar', 0),
(24, 6, 'Euro', 0),
(25, 7, 'Go', 0),
(26, 7, 'Gd', 0),
(27, 7, '(Correct) Au', 1),
(28, 7, 'Ag', 0),
(29, 8, 'Oxygen', 0),
(30, 8, '(Correct) Carbon Dioxide', 1),
(31, 8, 'Nitrogen', 0),
(32, 8, 'Hydrogen', 0),
(33, 9, 'Iron', 0),
(34, 9, 'Gold', 0),
(35, 9, '(Correct) Diamond', 1),
(36, 9, 'Graphite', 0),
(37, 10, 'A', 0),
(38, 10, 'B', 0),
(39, 10, 'AB', 0),
(40, 10, '(Correct) O', 1),
(41, 11, 'Heart', 0),
(42, 11, 'Liver', 0),
(43, 11, 'Brain', 0),
(44, 11, '(Correct) Skin', 1),
(45, 12, 'Earth', 0),
(46, 12, '(Correct) Jupiter', 1),
(47, 12, 'Saturn', 0),
(48, 12, 'Mars', 0),
(49, 13, '90°C\"', 0),
(50, 13, '(Correct) 100°C', 1),
(51, 13, '110°C', 0),
(52, 13, '120°C', 0),
(53, 14, 'Helium', 0),
(54, 14, 'Oxygen', 0),
(55, 14, '(Correct) Hydrogen', 1),
(56, 14, 'Carbon', 0),
(57, 15, 'Thomas Jefferson', 0),
(58, 15, 'Abraham Lincoln', 0),
(59, 15, '(Correct) George Washington', 1),
(60, 15, 'John Adams', 0),
(61, 16, '1943', 0),
(62, 16, '(Correct) 1945', 1),
(63, 16, '(Correct)', 0),
(64, 16, '1939', 0),
(65, 17, 'Greeks', 0),
(66, 17, 'Romans', 0),
(67, 17, '(Correct) Egyptians', 1),
(68, 17, 'Mayans', 0),
(69, 18, 'Vladimir Lenin', 0),
(70, 18, '(Correct) Karl Marx', 1),
(71, 18, 'Joseph Stalin', 0),
(72, 18, 'Friedrich Engels', 0),
(73, 19, 'Steven Spielberg', 0),
(74, 19, '(Correct) Christopher Nolan', 1),
(75, 19, 'Quentin Tarantino', 0),
(76, 19, 'James Cameron', 0),
(77, 20, 'James Cameron', 0),
(78, 20, '(Correct) Robert Downey Jr.', 1),
(79, 20, 'Mark Ruffalo', 0),
(80, 20, 'Chris Hemsworth', 0),
(81, 21, 'Gone with the Wind', 0),
(82, 21, '(Correct) Wings', 1),
(83, 21, 'Casablanca', 0),
(84, 21, 'The Jazz Singer', 0),
(85, 22, '(Correct) Avatar', 1),
(86, 22, 'Avengers: Endgame', 0),
(87, 22, 'Titanic', 0),
(88, 22, 'Star Wars: The Force Awakens', 0),
(89, 23, 'Brad Pitt', 0),
(90, 23, 'Tom Cruise', 0),
(91, 23, '(Correct) Leonardo DiCaprio', 1),
(92, 23, 'Johnny Depp', 0),
(93, 24, 'Germany', 0),
(94, 24, 'Brazil', 0),
(95, 24, '(Correct) France', 1),
(96, 24, 'Argentina', 0),
(97, 25, '9', 0),
(98, 25, '10', 0),
(99, 25, '(Correct) 11', 1),
(100, 25, '12', 0),
(101, 26, 'Tennis', 0),
(102, 26, '(Correct) Badminton', 1),
(103, 26, 'Squash', 0),
(104, 26, 'Table Tennis', 0),
(105, 27, '(Correct) Hyper Text Markup Language', 1),
(106, 27, 'High Tech Modern Language', 0),
(107, 27, 'Hyperlink and Text Management Language', 0),
(108, 27, 'Home Tool Management Language', 0),
(109, 28, 'Apple', 0),
(110, 28, 'Microsoft', 0),
(111, 28, '(Correct) Google', 1),
(112, 28, 'Samsung', 0),
(113, 29, '(Correct) Central Processing Unit', 1),
(114, 29, 'Computer Processing Unit', 0),
(115, 29, 'Control Processing Unit', 0),
(116, 29, 'Core Processing Unit', 0),
(117, 30, 'Python', 0),
(118, 30, 'Java', 0),
(119, 30, '(Correct) JavaScript', 1),
(120, 30, 'C++', 0),
(121, 31, '2005', 0),
(122, 31, '(Correct) 2007', 1),
(123, 31, '2010', 0),
(124, 31, '2012', 0),
(125, 32, 'Facebook', 0),
(126, 32, 'Amazon', 0),
(127, 32, '(Correct) Google', 1),
(128, 32, 'Microsoft', 0),
(129, 33, 'Atlas', 0),
(130, 33, '(Correct) Optimus', 1),
(131, 33, 'Sophia', 0),
(132, 33, 'Asimo', 0),
(133, 34, 'HTTP', 0),
(134, 34, 'FTP', 0),
(135, 34, '(Correct) SMTP', 1),
(136, 34, 'TCP', 0),
(137, 35, '(Correct) Virtual Private Network', 1),
(138, 35, 'Visual Personal Network', 0),
(139, 35, 'Verified Private Node', 0),
(140, 35, 'Virtual Public Network', 0),
(141, 36, 'IBM', 0),
(142, 36, 'Microsoft', 0),
(143, 36, '(Correct) Xerox', 1),
(144, 36, 'Apple', 0);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `question_text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `quiz_id`, `question_text`) VALUES
(1, 1, 'What is the capital of France?'),
(2, 1, 'Which planet is known as the \'Red Planet\'?'),
(3, 1, 'Which planet is known as the \'Red Planet\'?'),
(4, 1, 'Who painted the Mona Lisa?'),
(5, 1, 'Which country is home to the kangaroo?'),
(6, 1, 'What is the currency of Japan?'),
(7, 2, 'What is the chemical symbol for gold?'),
(8, 2, 'Which gas do plants absorb during photosynthesis?'),
(9, 2, 'What is the hardest natural substance on Earth?'),
(10, 2, 'Which blood type is the universal donor?'),
(11, 2, 'What is the largest organ in the human body?'),
(12, 2, 'Which planet has the most moons?'),
(13, 2, 'What is the boiling point of water in Celsius?'),
(14, 2, 'Which element has the atomic number 1?'),
(15, 3, 'Who was the first President of the United States?'),
(16, 3, 'In which year did World War II end?'),
(17, 3, 'In which year did World War II end?'),
(18, 3, 'In which year did World War II end?'),
(19, 4, 'Who directed the movie \'Inception\'?'),
(20, 4, 'Which actor played the role of Iron Man in the MCU?'),
(21, 4, 'Which movie won the first Academy Award for Best Picture?'),
(22, 4, 'What is the highest-grossing film of all time (as of 2023)?'),
(23, 4, 'Who played Jack in \'Titanic\'?'),
(24, 5, 'Which country won the FIFA World Cup in 2018?'),
(25, 5, 'How many players are on a standard soccer team during a match?'),
(26, 5, 'Which sport uses a shuttlecock?'),
(27, 6, 'What does \'HTML\' stand for?'),
(28, 6, 'Which company developed the Android operating system?'),
(29, 6, 'What does \'CPU\' stand for?'),
(30, 6, 'Which programming language is known as the \'language of the web\'?'),
(31, 6, 'What year was the first iPhone released?'),
(32, 6, 'Which tech giant owns YouTube?'),
(33, 6, 'What is the name of Tesla\'s humanoid robot project?'),
(34, 6, 'Which protocol is used to send emails?'),
(35, 6, 'What does \'VPN\' stand for?'),
(36, 6, 'Which company created the first computer mouse?');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--
DROP TABLE IF EXISTS `quizzes`;
CREATE TABLE `quizzes` (
  `quiz_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `time_set` int(11) NOT NULL,
  `description` text NOT NULL,
  `max_score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`quiz_id`, `title`, `time_set`, `description`, `max_score`) VALUES
(1, 'Demo Quiz 1 (General Knowledge)', 20, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 30),
(2, 'Demo Quiz 2 (Science & Nature)', 30, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 30),
(3, 'Demo Quiz 3 (History)', 20, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a mauris eu sem facilisis iaculis id sed ante. Pellentesque vitae lacinia ligula. Aenean sit amet neque at elit sollicitudin dignissim at et lacus.', 30),
(4, 'Demo Quiz 4 (Movies & Entertainment)', 30, 'Aliquam quis eros sit amet nisi pulvinar maximus in a dui. Vestibulum tristique fermentum magna sed malesuada. Etiam tempus augue quis molestie sollicitudin. Phasellus dignissim a nunc a mattis.', 50),
(5, 'Demo Quiz 5 (Sports)', 15, 'Suspendisse lobortis nisi eget tellus sollicitudin fringilla. Donec non augue quam. Mauris elit sapien, pretium id ultricies ac, vehicula at erat. Vestibulum non diam mauris. ', 30),
(6, 'Demo Quiz 6 (Technology)', 60, 'Proin neque mi, scelerisque ac leo sit amet, malesuada molestie eros. Aliquam mattis consectetur blandit. Etiam vulputate, urna quis lobortis elementum, ex turpis aliquam quam', 100);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`quiz_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
