import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../utils/google_colors.dart';

class QuizData {
  static List<QuizCategory> getCategories() {
    return [
      QuizCategory(
        id: 'science',
        name: 'Science',
        description: 'Physics, Chemistry, Biology',
        icon: Icons.science,
        color: GoogleColors.blue,
        totalQuizzes: 3,
        quizzes: _getScienceQuizzes(),
      ),
      QuizCategory(
        id: 'mathematics',
        name: 'Mathematics',
        description: 'Algebra, Geometry, Calculus',
        icon: Icons.calculate,
        color: GoogleColors.red,
        totalQuizzes: 2,
        quizzes: _getMathQuizzes(),
      ),
      QuizCategory(
        id: 'history',
        name: 'History',
        description: 'World History, Ancient Civilizations',
        icon: Icons.history_edu,
        color: GoogleColors.yellow,
        totalQuizzes: 2,
        quizzes: _getHistoryQuizzes(),
      ),
      QuizCategory(
        id: 'technology',
        name: 'Technology',
        description: 'Programming, AI, Gadgets',
        icon: Icons.computer,
        color: GoogleColors.green,
        totalQuizzes: 3,
        quizzes: _getTechQuizzes(),
      ),
      QuizCategory(
        id: 'geography',
        name: 'Geography',
        description: 'Countries, Capitals, Landmarks',
        icon: Icons.public,
        color: const Color(0xFF9C27B0),
        totalQuizzes: 2,
        quizzes: _getGeographyQuizzes(),
      ),
      QuizCategory(
        id: 'sports',
        name: 'Sports',
        description: 'Football, Cricket, Olympics',
        icon: Icons.sports_soccer,
        color: const Color(0xFF00BCD4),
        totalQuizzes: 2,
        quizzes: _getSportsQuizzes(),
      ),
    ];
  }

  static List<Quiz> _getScienceQuizzes() {
    return [
      Quiz(
        id: 'sci_1',
        title: 'Basic Physics',
        description: 'Test your physics fundamentals',
        timeInMinutes: 10,
        difficulty: 'Easy',
        categoryId: 'science',
        questions: [
          Question(
            id: 'q1',
            questionText: 'What is the SI unit of force?',
            options: ['Joule', 'Newton', 'Watt', 'Pascal'],
            correctAnswerIndex: 1,
            explanation: 'Newton (N) is the SI unit of force, named after Sir Isaac Newton.',
          ),
          Question(
            id: 'q2',
            questionText: 'What is the speed of light in vacuum?',
            options: ['3 × 10⁶ m/s', '3 × 10⁸ m/s', '3 × 10¹⁰ m/s', '3 × 10⁴ m/s'],
            correctAnswerIndex: 1,
            explanation: 'The speed of light in vacuum is approximately 3 × 10⁸ meters per second.',
          ),
          Question(
            id: 'q3',
            questionText: 'Which planet is known as the Red Planet?',
            options: ['Venus', 'Jupiter', 'Mars', 'Saturn'],
            correctAnswerIndex: 2,
            explanation: 'Mars is called the Red Planet due to iron oxide on its surface.',
          ),
          Question(
            id: 'q4',
            questionText: 'What is the chemical symbol for Gold?',
            options: ['Go', 'Gd', 'Au', 'Ag'],
            correctAnswerIndex: 2,
            explanation: 'Au comes from the Latin word "Aurum" meaning gold.',
          ),
          Question(
            id: 'q5',
            questionText: 'What is the largest organ in the human body?',
            options: ['Heart', 'Liver', 'Brain', 'Skin'],
            correctAnswerIndex: 3,
            explanation: 'Skin is the largest organ, covering about 20 square feet in adults.',
          ),
        ],
      ),
      Quiz(
        id: 'sci_2',
        title: 'Chemistry Basics',
        description: 'Explore the world of chemistry',
        timeInMinutes: 8,
        difficulty: 'Medium',
        categoryId: 'science',
        questions: [
          Question(
            id: 'q1',
            questionText: 'What is the atomic number of Carbon?',
            options: ['4', '6', '8', '12'],
            correctAnswerIndex: 1,
            explanation: 'Carbon has 6 protons, so its atomic number is 6.',
          ),
          Question(
            id: 'q2',
            questionText: 'Which gas is most abundant in Earth\'s atmosphere?',
            options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Argon'],
            correctAnswerIndex: 2,
            explanation: 'Nitrogen makes up about 78% of Earth\'s atmosphere.',
          ),
          Question(
            id: 'q3',
            questionText: 'What is H₂O commonly known as?',
            options: ['Hydrogen Peroxide', 'Water', 'Heavy Water', 'Hydroxide'],
            correctAnswerIndex: 1,
            explanation: 'H₂O is the chemical formula for water.',
          ),
          Question(
            id: 'q4',
            questionText: 'What is the pH of pure water?',
            options: ['0', '7', '14', '1'],
            correctAnswerIndex: 1,
            explanation: 'Pure water has a neutral pH of 7.',
          ),
        ],
      ),
    ];
  }

  static List<Quiz> _getMathQuizzes() {
    return [
      Quiz(
        id: 'math_1',
        title: 'Quick Math',
        description: 'Basic arithmetic and algebra',
        timeInMinutes: 5,
        difficulty: 'Easy',
        categoryId: 'mathematics',
        questions: [
          Question(
            id: 'q1',
            questionText: 'What is 15 × 12?',
            options: ['160', '170', '180', '190'],
            correctAnswerIndex: 2,
            explanation: '15 × 12 = 180',
          ),
          Question(
            id: 'q2',
            questionText: 'If x + 5 = 12, what is x?',
            options: ['5', '6', '7', '8'],
            correctAnswerIndex: 2,
            explanation: 'x = 12 - 5 = 7',
          ),
          Question(
            id: 'q3',
            questionText: 'What is the square root of 144?',
            options: ['10', '11', '12', '13'],
            correctAnswerIndex: 2,
            explanation: '√144 = 12 because 12 × 12 = 144',
          ),
          Question(
            id: 'q4',
            questionText: 'What is 25% of 200?',
            options: ['25', '50', '75', '100'],
            correctAnswerIndex: 1,
            explanation: '25% of 200 = (25/100) × 200 = 50',
          ),
          Question(
            id: 'q5',
            questionText: 'What is the value of π (pi) approximately?',
            options: ['2.14', '3.14', '4.14', '5.14'],
            correctAnswerIndex: 1,
            explanation: 'π is approximately equal to 3.14159...',
          ),
        ],
      ),
    ];
  }

  static List<Quiz> _getHistoryQuizzes() {
    return [
      Quiz(
        id: 'hist_1',
        title: 'World History',
        description: 'Major events that shaped our world',
        timeInMinutes: 10,
        difficulty: 'Medium',
        categoryId: 'history',
        questions: [
          Question(
            id: 'q1',
            questionText: 'In which year did World War II end?',
            options: ['1943', '1944', '1945', '1946'],
            correctAnswerIndex: 2,
            explanation: 'World War II ended in 1945 with the surrender of Japan.',
          ),
          Question(
            id: 'q2',
            questionText: 'Who was the first President of the United States?',
            options: ['Abraham Lincoln', 'Thomas Jefferson', 'George Washington', 'John Adams'],
            correctAnswerIndex: 2,
            explanation: 'George Washington served as the first U.S. President from 1789 to 1797.',
          ),
          Question(
            id: 'q3',
            questionText: 'The Great Wall of China was primarily built to protect against invasions from?',
            options: ['Japan', 'Mongolia', 'Korea', 'India'],
            correctAnswerIndex: 1,
            explanation: 'The Great Wall was built to protect against Mongol invasions.',
          ),
          Question(
            id: 'q4',
            questionText: 'Who discovered America in 1492?',
            options: ['Vasco da Gama', 'Ferdinand Magellan', 'Christopher Columbus', 'Marco Polo'],
            correctAnswerIndex: 2,
            explanation: 'Christopher Columbus reached the Americas in 1492.',
          ),
        ],
      ),
    ];
  }

  static List<Quiz> _getTechQuizzes() {
    return [
      Quiz(
        id: 'tech_1',
        title: 'Programming Basics',
        description: 'Test your coding knowledge',
        timeInMinutes: 8,
        difficulty: 'Easy',
        categoryId: 'technology',
        questions: [
          Question(
            id: 'q1',
            questionText: 'What does HTML stand for?',
            options: [
              'Hyper Text Markup Language',
              'High Tech Modern Language',
              'Hyper Transfer Markup Language',
              'Home Tool Markup Language'
            ],
            correctAnswerIndex: 0,
            explanation: 'HTML = Hyper Text Markup Language, used for creating web pages.',
          ),
          Question(
            id: 'q2',
            questionText: 'Which programming language is known as the "language of the web"?',
            options: ['Python', 'Java', 'JavaScript', 'C++'],
            correctAnswerIndex: 2,
            explanation: 'JavaScript runs in browsers and is essential for web development.',
          ),
          Question(
            id: 'q3',
            questionText: 'What does CPU stand for?',
            options: [
              'Central Processing Unit',
              'Computer Personal Unit',
              'Central Program Utility',
              'Computer Processing Unit'
            ],
            correctAnswerIndex: 0,
            explanation: 'CPU = Central Processing Unit, the brain of a computer.',
          ),
          Question(
            id: 'q4',
            questionText: 'Which company developed the Flutter framework?',
            options: ['Facebook', 'Apple', 'Google', 'Microsoft'],
            correctAnswerIndex: 2,
            explanation: 'Flutter was developed by Google for cross-platform development.',
          ),
          Question(
            id: 'q5',
            questionText: 'What does API stand for?',
            options: [
              'Application Programming Interface',
              'Advanced Program Integration',
              'Automated Processing Input',
              'Application Process Integration'
            ],
            correctAnswerIndex: 0,
            explanation: 'API = Application Programming Interface',
          ),
        ],
      ),
      Quiz(
        id: 'tech_2',
        title: 'AI & Machine Learning',
        description: 'Explore the world of AI',
        timeInMinutes: 10,
        difficulty: 'Hard',
        categoryId: 'technology',
        questions: [
          Question(
            id: 'q1',
            questionText: 'What does AI stand for?',
            options: [
              'Automated Intelligence',
              'Artificial Intelligence',
              'Advanced Integration',
              'Algorithmic Information'
            ],
            correctAnswerIndex: 1,
            explanation: 'AI = Artificial Intelligence',
          ),
          Question(
            id: 'q2',
            questionText: 'Which company created ChatGPT?',
            options: ['Google', 'Microsoft', 'OpenAI', 'Meta'],
            correctAnswerIndex: 2,
            explanation: 'ChatGPT was created by OpenAI.',
          ),
          Question(
            id: 'q3',
            questionText: 'What is the process of training a model on labeled data called?',
            options: [
              'Unsupervised Learning',
              'Supervised Learning',
              'Reinforcement Learning',
              'Transfer Learning'
            ],
            correctAnswerIndex: 1,
            explanation: 'Supervised learning uses labeled data for training.',
          ),
        ],
      ),
    ];
  }

  static List<Quiz> _getGeographyQuizzes() {
    return [
      Quiz(
        id: 'geo_1',
        title: 'World Capitals',
        description: 'Test your knowledge of capitals',
        timeInMinutes: 5,
        difficulty: 'Easy',
        categoryId: 'geography',
        questions: [
          Question(
            id: 'q1',
            questionText: 'What is the capital of Japan?',
            options: ['Osaka', 'Kyoto', 'Tokyo', 'Nagoya'],
            correctAnswerIndex: 2,
            explanation: 'Tokyo is the capital city of Japan.',
          ),
          Question(
            id: 'q2',
            questionText: 'Which is the largest country by area?',
            options: ['China', 'United States', 'Canada', 'Russia'],
            correctAnswerIndex: 3,
            explanation: 'Russia is the largest country with 17.1 million km².',
          ),
          Question(
            id: 'q3',
            questionText: 'What is the capital of Australia?',
            options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
            correctAnswerIndex: 2,
            explanation: 'Canberra is the capital of Australia, not Sydney.',
          ),
          Question(
            id: 'q4',
            questionText: 'Which river is the longest in the world?',
            options: ['Amazon', 'Nile', 'Yangtze', 'Mississippi'],
            correctAnswerIndex: 1,
            explanation: 'The Nile River is approximately 6,650 km long.',
          ),
        ],
      ),
    ];
  }

  static List<Quiz> _getSportsQuizzes() {
    return [
      Quiz(
        id: 'sport_1',
        title: 'Football World Cup',
        description: 'FIFA World Cup trivia',
        timeInMinutes: 5,
        difficulty: 'Medium',
        categoryId: 'sports',
        questions: [
          Question(
            id: 'q1',
            questionText: 'Which country has won the most FIFA World Cups?',
            options: ['Germany', 'Argentina', 'Brazil', 'Italy'],
            correctAnswerIndex: 2,
            explanation: 'Brazil has won 5 FIFA World Cups (1958, 1962, 1970, 1994, 2002).',
          ),
          Question(
            id: 'q2',
            questionText: 'In which year was the first FIFA World Cup held?',
            options: ['1926', '1930', '1934', '1938'],
            correctAnswerIndex: 1,
            explanation: 'The first World Cup was held in Uruguay in 1930.',
          ),
          Question(
            id: 'q3',
            questionText: 'Who won the FIFA World Cup 2022?',
            options: ['France', 'Brazil', 'Argentina', 'Germany'],
            correctAnswerIndex: 2,
            explanation: 'Argentina won the 2022 World Cup in Qatar.',
          ),
          Question(
            id: 'q4',
            questionText: 'How many players are on a football team on the field?',
            options: ['9', '10', '11', '12'],
            correctAnswerIndex: 2,
            explanation: 'Each team has 11 players on the field.',
          ),
        ],
      ),
    ];
  }
}
