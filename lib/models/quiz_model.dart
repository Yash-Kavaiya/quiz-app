import 'package:flutter/material.dart';

class QuizCategory {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final int totalQuizzes;
  final List<Quiz> quizzes;

  QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.totalQuizzes,
    required this.quizzes,
  });
}

class Quiz {
  final String id;
  final String title;
  final String description;
  final int timeInMinutes;
  final String difficulty;
  final List<Question> questions;
  final String categoryId;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.timeInMinutes,
    required this.difficulty,
    required this.questions,
    required this.categoryId,
  });

  int get totalQuestions => questions.length;
}

class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String? explanation;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation,
  });
}

class QuizResult {
  final Quiz quiz;
  final int correctAnswers;
  final int totalQuestions;
  final int timeTaken; // in seconds
  final List<int?> userAnswers;

  QuizResult({
    required this.quiz,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeTaken,
    required this.userAnswers,
  });

  double get percentage => (correctAnswers / totalQuestions) * 100;

  String get grade {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    if (percentage >= 50) return 'D';
    return 'F';
  }

  String get performanceMessage {
    if (percentage >= 90) return 'Outstanding! 🏆';
    if (percentage >= 80) return 'Excellent Work! 🌟';
    if (percentage >= 70) return 'Great Job! 👏';
    if (percentage >= 60) return 'Good Effort! 👍';
    if (percentage >= 50) return 'Keep Practicing! 💪';
    return 'Need More Practice 📚';
  }
}
