import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/quiz_model.dart';
import '../utils/google_colors.dart';
import 'quiz_screen.dart';

class QuizListScreen extends StatelessWidget {
  final QuizCategory category;

  const QuizListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GoogleColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            backgroundColor: category.color,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                category.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      category.color,
                      category.color.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -40,
                      top: -40,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 60,
                      child: Icon(
                        category.icon,
                        size: 60,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Description
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        category.icon,
                        color: category.color,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: GoogleColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${category.quizzes.length} quizzes available',
                            style: TextStyle(
                              fontSize: 13,
                              color: category.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),
            ),
          ),

          // Section Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Available Quizzes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: GoogleColors.textPrimary,
                ),
              ),
            ),
          ),

          // Quiz List
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final quiz = category.quizzes[index];
                  return _buildQuizCard(context, quiz, index);
                },
                childCount: category.quizzes.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context, Quiz quiz, int index) {
    Color difficultyColor;
    IconData difficultyIcon;

    switch (quiz.difficulty.toLowerCase()) {
      case 'easy':
        difficultyColor = GoogleColors.green;
        difficultyIcon = Icons.signal_cellular_alt_1_bar;
        break;
      case 'medium':
        difficultyColor = GoogleColors.yellow;
        difficultyIcon = Icons.signal_cellular_alt_2_bar;
        break;
      case 'hard':
        difficultyColor = GoogleColors.red;
        difficultyIcon = Icons.signal_cellular_alt;
        break;
      default:
        difficultyColor = GoogleColors.blue;
        difficultyIcon = Icons.signal_cellular_alt;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            _showStartQuizDialog(context, quiz);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.quiz_outlined,
                        color: category.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: GoogleColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            quiz.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: GoogleColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.help_outline,
                      '${quiz.totalQuestions} Questions',
                      GoogleColors.blue,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.timer_outlined,
                      '${quiz.timeInMinutes} min',
                      GoogleColors.green,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      difficultyIcon,
                      quiz.difficulty,
                      difficultyColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showStartQuizDialog(context, quiz),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: category.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Start Quiz',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate(delay: Duration(milliseconds: 100 * index)).fadeIn().slideX(
          begin: 0.2,
          end: 0,
          duration: const Duration(milliseconds: 400),
        );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showStartQuizDialog(BuildContext context, Quiz quiz) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_circle_filled,
                color: category.color,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              quiz.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: GoogleColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              quiz.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: GoogleColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(
                  Icons.help_outline,
                  '${quiz.totalQuestions}',
                  'Questions',
                  GoogleColors.blue,
                ),
                _buildStatItem(
                  Icons.timer_outlined,
                  '${quiz.timeInMinutes}',
                  'Minutes',
                  GoogleColors.green,
                ),
                _buildStatItem(
                  Icons.star_outline,
                  quiz.difficulty,
                  'Level',
                  GoogleColors.yellow,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: GoogleColors.textSecondary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: GoogleColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                            quiz: quiz,
                            categoryColor: category.color,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: category.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow),
                        SizedBox(width: 8),
                        Text(
                          'Start Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: GoogleColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: GoogleColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
