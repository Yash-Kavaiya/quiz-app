import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti_widget/confetti_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/quiz_model.dart';
import '../utils/google_colors.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  final QuizResult result;
  final Color categoryColor;

  const ResultScreen({
    super.key,
    required this.result,
    required this.categoryColor,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));

    // Play confetti if score is good
    if (widget.result.percentage >= 70) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    if (minutes > 0) {
      return '$minutes min ${secs}s';
    }
    return '${secs}s';
  }

  @override
  Widget build(BuildContext context) {
    Color scoreColor = widget.result.percentage >= 70
        ? GoogleColors.green
        : widget.result.percentage >= 50
            ? GoogleColors.yellow
            : GoogleColors.red;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: GoogleColors.backgroundLight,
        body: Stack(
          children: [
            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.2,
                shouldLoop: false,
                colors: [
                  GoogleColors.blue,
                  GoogleColors.red,
                  GoogleColors.yellow,
                  GoogleColors.green,
                ],
              ),
            ),

            // Content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Result Header
                    _buildResultHeader(scoreColor).animate().fadeIn().scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                          duration: const Duration(milliseconds: 500),
                        ),

                    const SizedBox(height: 32),

                    // Stats Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.check_circle,
                            value: '${widget.result.correctAnswers}',
                            label: 'Correct',
                            color: GoogleColors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.cancel,
                            value: '${widget.result.totalQuestions - widget.result.correctAnswers}',
                            label: 'Wrong',
                            color: GoogleColors.red,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.timer,
                            value: _formatTime(widget.result.timeTaken),
                            label: 'Time',
                            color: GoogleColors.blue,
                          ),
                        ),
                      ],
                    ).animate(delay: const Duration(milliseconds: 300)).fadeIn().slideY(
                          begin: 0.2,
                          end: 0,
                        ),

                    const SizedBox(height: 24),

                    // Question Review Section
                    _buildReviewSection().animate(delay: const Duration(milliseconds: 500)).fadeIn(),

                    const SizedBox(height: 24),

                    // Action Buttons
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultHeader(Color scoreColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: scoreColor.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Performance emoji and message
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: scoreColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              widget.result.percentage >= 90
                  ? '🏆'
                  : widget.result.percentage >= 70
                      ? '🌟'
                      : widget.result.percentage >= 50
                          ? '👍'
                          : '📚',
              style: const TextStyle(fontSize: 50),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            widget.result.performanceMessage,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: scoreColor,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            widget.result.quiz.title,
            style: TextStyle(
              fontSize: 16,
              color: GoogleColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          // Score circle
          CircularPercentIndicator(
            radius: 80,
            lineWidth: 12,
            percent: widget.result.percentage / 100,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.result.percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: scoreColor,
                  ),
                ),
                Text(
                  'Score',
                  style: TextStyle(
                    fontSize: 14,
                    color: GoogleColors.textSecondary,
                  ),
                ),
              ],
            ),
            progressColor: scoreColor,
            backgroundColor: scoreColor.withOpacity(0.2),
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animationDuration: 1500,
          ),

          const SizedBox(height: 20),

          // Grade badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [scoreColor, scoreColor.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: scoreColor.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Grade: ${widget.result.grade}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }

  Widget _buildReviewSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment, color: widget.categoryColor),
              const SizedBox(width: 8),
              Text(
                'Question Review',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: GoogleColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(widget.result.quiz.questions.length, (index) {
            final question = widget.result.quiz.questions[index];
            final userAnswer = widget.result.userAnswers[index];
            final isCorrect = userAnswer == question.correctAnswerIndex;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCorrect
                    ? GoogleColors.green.withOpacity(0.1)
                    : GoogleColors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCorrect
                      ? GoogleColors.green.withOpacity(0.3)
                      : GoogleColors.red.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: isCorrect ? GoogleColors.green : GoogleColors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            isCorrect ? Icons.check : Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Q${index + 1}: ${question.questionText}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: GoogleColors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (!isCorrect && userAnswer != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 38),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your answer: ${question.options[userAnswer]}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: GoogleColors.red,
                                ),
                              ),
                              Text(
                                'Correct: ${question.options[question.correctAnswerIndex]}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: GoogleColors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (question.explanation != null && !isCorrect) ...[
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(left: 38),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: GoogleColors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 14,
                            color: GoogleColors.blue,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              question.explanation!,
                              style: TextStyle(
                                fontSize: 11,
                                color: GoogleColors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Retry button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    quiz: widget.result.quiz,
                    categoryColor: widget.categoryColor,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.refresh),
            label: const Text(
              'Try Again',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.categoryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ).animate(delay: const Duration(milliseconds: 600)).fadeIn().slideY(
              begin: 0.2,
              end: 0,
            ),

        const SizedBox(height: 12),

        // Home button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.home),
            label: const Text(
              'Back to Home',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: widget.categoryColor,
              side: BorderSide(color: widget.categoryColor, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ).animate(delay: const Duration(milliseconds: 700)).fadeIn().slideY(
              begin: 0.2,
              end: 0,
            ),

        const SizedBox(height: 12),

        // Share button
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Share feature coming soon!'),
                  backgroundColor: GoogleColors.blue,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            icon: Icon(Icons.share, color: GoogleColors.textSecondary),
            label: Text(
              'Share Result',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: GoogleColors.textSecondary,
              ),
            ),
          ),
        ).animate(delay: const Duration(milliseconds: 800)).fadeIn(),
      ],
    );
  }
}
