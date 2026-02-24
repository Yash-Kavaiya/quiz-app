import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/google_colors.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to QuizMaster Pro',
      description: 'Your ultimate platform for quizzes and mock tests. Challenge yourself and track your progress!',
      icon: Icons.quiz,
      color: GoogleColors.blue,
    ),
    OnboardingPage(
      title: 'Multiple Categories',
      description: 'Explore quizzes across Science, Math, History, Technology, Geography, and Sports.',
      icon: Icons.category,
      color: GoogleColors.red,
    ),
    OnboardingPage(
      title: 'Track Your Progress',
      description: 'Get instant results, detailed explanations, and performance analytics for every quiz.',
      icon: Icons.trending_up,
      color: GoogleColors.green,
    ),
    OnboardingPage(
      title: 'Ready to Begin?',
      description: 'Start your learning journey now and become a quiz master!',
      icon: Icons.rocket_launch,
      color: GoogleColors.yellow,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.2, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              GoogleColors.backgroundLight,
              _pages[_currentPage].color.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _navigateToHome,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: GoogleColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // Page content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),

              // Page indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 10,
                      width: _currentPage == index ? 30 : 10,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? _pages[index].color
                            : GoogleColors.textSecondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),

              // Navigation buttons
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    if (_currentPage > 0)
                      TextButton.icon(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: Icon(Icons.arrow_back, color: GoogleColors.textSecondary),
                        label: Text(
                          'Back',
                          style: TextStyle(color: GoogleColors.textSecondary),
                        ),
                      )
                    else
                      const SizedBox(width: 80),

                    // Next/Start button
                    ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _pages[_currentPage].color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == _pages.length - 1
                                ? Icons.rocket_launch
                                : Icons.arrow_forward,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container with animation
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.15),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: page.color.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              page.icon,
              size: 90,
              color: page.color,
            ),
          ).animate().scale(
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
              ),

          const SizedBox(height: 48),

          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: GoogleColors.textPrimary,
            ),
          ).animate().fadeIn(duration: const Duration(milliseconds: 400)).slideY(
                begin: 0.3,
                end: 0,
                duration: const Duration(milliseconds: 400),
              ),

          const SizedBox(height: 16),

          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: GoogleColors.textSecondary,
              height: 1.5,
            ),
          ).animate(delay: const Duration(milliseconds: 200)).fadeIn().slideY(
                begin: 0.3,
                end: 0,
                duration: const Duration(milliseconds: 400),
              ),

          const SizedBox(height: 32),

          // Feature chips for certain pages
          if (page.icon == Icons.category)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildChip('Science', GoogleColors.blue),
                _buildChip('Math', GoogleColors.red),
                _buildChip('History', GoogleColors.yellow),
                _buildChip('Tech', GoogleColors.green),
                _buildChip('Geography', const Color(0xFF9C27B0)),
                _buildChip('Sports', const Color(0xFF00BCD4)),
              ],
            ).animate(delay: const Duration(milliseconds: 400)).fadeIn().scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: const Duration(milliseconds: 400),
                ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
