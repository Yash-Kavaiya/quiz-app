import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/quiz_model.dart';
import '../utils/google_colors.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  final Color categoryColor;

  const QuizScreen({
    super.key,
    required this.quiz,
    required this.categoryColor,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  List<int?> _userAnswers = [];
  late Timer _timer;
  int _remainingSeconds = 0;
  int _elapsedSeconds = 0;
  bool _isAnswered = false;
  late AnimationController _progressController;

  // Google colors for options
  final List<Color> _optionColors = [
    GoogleColors.blue,
    GoogleColors.red,
    GoogleColors.yellow,
    GoogleColors.green,
  ];

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.quiz.timeInMinutes * 60;
    _userAnswers = List.filled(widget.quiz.questions.length, null);
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.quiz.timeInMinutes * 60),
    )..forward();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          _elapsedSeconds++;
        });
      } else {
        _timer.cancel();
        _finishQuiz();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _progressController.dispose();
    super.dispose();
  }

  Question get _currentQuestion => widget.quiz.questions[_currentQuestionIndex];

  void _selectAnswer(int index) {
    if (_isAnswered) return;

    setState(() {
      _selectedAnswer = index;
      _isAnswered = true;
      _userAnswers[_currentQuestionIndex] = index;
    });

    // Auto proceed after a short delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted && _isAnswered) {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = _userAnswers[_currentQuestionIndex];
        _isAnswered = _selectedAnswer != null;
      });
    } else {
      _finishQuiz();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedAnswer = _userAnswers[_currentQuestionIndex];
        _isAnswered = _selectedAnswer != null;
      });
    }
  }

  void _finishQuiz() {
    _timer.cancel();

    int correctAnswers = 0;
    for (int i = 0; i < widget.quiz.questions.length; i++) {
      if (_userAnswers[i] == widget.quiz.questions[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }

    final result = QuizResult(
      quiz: widget.quiz,
      correctAnswers: correctAnswers,
      totalQuestions: widget.quiz.questions.length,
      timeTaken: _elapsedSeconds,
      userAnswers: _userAnswers,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          result: result,
          categoryColor: widget.categoryColor,
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentQuestionIndex + 1) / widget.quiz.questions.length;
    double timeProgress = _remainingSeconds / (widget.quiz.timeInMinutes * 60);

    return WillPopScope(
      onWillPop: () async {
        return await _showExitDialog() ?? false;
      },
      child: Scaffold(
        backgroundColor: GoogleColors.backgroundLight,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(progress, timeProgress),

              // Question Area
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question Card
                      _buildQuestionCard().animate().fadeIn().slideY(
                            begin: 0.1,
                            end: 0,
                            duration: const Duration(milliseconds: 300),
                          ),

                      const SizedBox(height: 24),

                      // Options
                      ..._buildOptions(),
                    ],
                  ),
                ),
              ),

              // Navigation
              _buildNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double progress, double timeProgress) {
    Color timerColor = timeProgress > 0.5
        ? GoogleColors.green
        : timeProgress > 0.25
            ? GoogleColors.yellow
            : GoogleColors.red;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Back button
              IconButton(
                onPressed: () async {
                  if (await _showExitDialog() ?? false) {
                    Navigator.pop(context);
                  }
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: GoogleColors.backgroundLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.close, color: GoogleColors.textSecondary),
                ),
              ),

              const SizedBox(width: 8),

              // Quiz title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.quiz.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: GoogleColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Question ${_currentQuestionIndex + 1} of ${widget.quiz.questions.length}',
                      style: TextStyle(
                        fontSize: 12,
                        color: GoogleColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Timer
              CircularPercentIndicator(
                radius: 30,
                lineWidth: 4,
                percent: timeProgress.clamp(0.0, 1.0),
                center: Text(
                  _formatTime(_remainingSeconds),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: timerColor,
                  ),
                ),
                progressColor: timerColor,
                backgroundColor: timerColor.withOpacity(0.2),
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: GoogleColors.backgroundLight,
              valueColor: AlwaysStoppedAnimation<Color>(widget.categoryColor),
              minHeight: 8,
            ),
          ),

          const SizedBox(height: 8),

          // Question indicators
          SizedBox(
            height: 24,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.quiz.questions.length,
              itemBuilder: (context, index) {
                bool isCurrent = index == _currentQuestionIndex;
                bool isAnswered = _userAnswers[index] != null;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentQuestionIndex = index;
                      _selectedAnswer = _userAnswers[index];
                      _isAnswered = _selectedAnswer != null;
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? widget.categoryColor
                          : isAnswered
                              ? widget.categoryColor.withOpacity(0.3)
                              : GoogleColors.backgroundLight,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isCurrent
                            ? widget.categoryColor
                            : GoogleColors.textSecondary.withOpacity(0.3),
                        width: isCurrent ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isCurrent
                              ? Colors.white
                              : isAnswered
                                  ? widget.categoryColor
                                  : GoogleColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: widget.categoryColor.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.categoryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Question ${_currentQuestionIndex + 1}',
              style: TextStyle(
                color: widget.categoryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _currentQuestion.questionText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: GoogleColors.textPrimary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOptions() {
    return List.generate(_currentQuestion.options.length, (index) {
      bool isSelected = _selectedAnswer == index;
      bool isCorrect = _currentQuestion.correctAnswerIndex == index;
      bool showResult = _isAnswered;

      Color optionColor = _optionColors[index % _optionColors.length];

      Color bgColor;
      Color borderColor;
      Color textColor;
      IconData? icon;

      if (showResult) {
        if (isCorrect) {
          bgColor = GoogleColors.green.withOpacity(0.15);
          borderColor = GoogleColors.green;
          textColor = GoogleColors.green;
          icon = Icons.check_circle;
        } else if (isSelected && !isCorrect) {
          bgColor = GoogleColors.red.withOpacity(0.15);
          borderColor = GoogleColors.red;
          textColor = GoogleColors.red;
          icon = Icons.cancel;
        } else {
          bgColor = Colors.white;
          borderColor = GoogleColors.textSecondary.withOpacity(0.2);
          textColor = GoogleColors.textSecondary;
          icon = null;
        }
      } else {
        if (isSelected) {
          bgColor = optionColor.withOpacity(0.15);
          borderColor = optionColor;
          textColor = optionColor;
        } else {
          bgColor = Colors.white;
          borderColor = GoogleColors.textSecondary.withOpacity(0.2);
          textColor = GoogleColors.textPrimary;
        }
        icon = null;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          onTap: () => _selectAnswer(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 2),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: borderColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                // Option letter badge
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: showResult
                        ? (isCorrect
                            ? GoogleColors.green
                            : isSelected
                                ? GoogleColors.red
                                : optionColor.withOpacity(0.1))
                        : (isSelected
                            ? optionColor
                            : optionColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: icon != null
                        ? Icon(icon, color: Colors.white, size: 22)
                        : Text(
                            String.fromCharCode(65 + index),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : optionColor,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                // Option text
                Expanded(
                  child: Text(
                    _currentQuestion.options[index],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate(delay: Duration(milliseconds: 100 * index)).fadeIn().slideX(
            begin: 0.1,
            end: 0,
            duration: const Duration(milliseconds: 300),
          );
    });
  }

  Widget _buildNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Previous button
          if (_currentQuestionIndex > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _previousQuestion,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: GoogleColors.textSecondary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          else
            const Expanded(child: SizedBox()),

          const SizedBox(width: 12),

          // Next/Finish button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _isAnswered
                  ? (_currentQuestionIndex < widget.quiz.questions.length - 1
                      ? _nextQuestion
                      : _finishQuiz)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.categoryColor,
                foregroundColor: Colors.white,
                disabledBackgroundColor: GoogleColors.textSecondary.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentQuestionIndex < widget.quiz.questions.length - 1
                        ? 'Next Question'
                        : 'Finish Quiz',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _currentQuestionIndex < widget.quiz.questions.length - 1
                        ? Icons.arrow_forward
                        : Icons.check,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showExitDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: GoogleColors.yellow),
            const SizedBox(width: 12),
            const Text('Exit Quiz?'),
          ],
        ),
        content: const Text(
          'Your progress will be lost. Are you sure you want to exit?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: GoogleColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: GoogleColors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}
