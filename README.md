# QuizMaster Pro

A beautiful Flutter Quiz and Mock Test Platform with Google-themed UI, featuring category-wise quizzes, timed tests, and detailed results.

## Features

- **Welcome/Onboarding Screen**: Beautiful 4-page onboarding with animations
- **Category-Based Home Screen**: Browse quizzes by category (Science, Math, History, Technology, Geography, Sports)
- **Interactive Quiz Screen**:
  - Google color-themed options (Blue, Red, Yellow, Green)
  - Countdown timer with visual indicator
  - Question navigation with progress tracking
  - Instant feedback on answers
- **Result Screen**:
  - Score percentage with animated circular progress
  - Grade calculation (A+ to F)
  - Confetti celebration for good scores
  - Detailed question review with explanations

## Screenshots

The app features:
- Clean, modern Material 3 design
- Google Poppins font family
- Smooth animations throughout
- Gradient cards and shadows for depth

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone this repository
2. Navigate to project directory:
   ```bash
   cd quiz-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── data/
│   └── quiz_data.dart       # Sample quiz data
├── models/
│   └── quiz_model.dart      # Data models
├── screens/
│   ├── welcome_screen.dart  # Onboarding pages
│   ├── home_screen.dart     # Category grid
│   ├── quiz_list_screen.dart # Quizzes in category
│   ├── quiz_screen.dart     # Quiz gameplay
│   └── result_screen.dart   # Results & review
└── utils/
    └── google_colors.dart   # Google color palette
```

## Dependencies

- `google_fonts` - Poppins font family
- `percent_indicator` - Circular progress indicators
- `flutter_animate` - Smooth animations
- `confetti_widget` - Celebration effects
- `shared_preferences` - Local storage (for future use)

## Customization

### Adding New Categories

Edit `lib/data/quiz_data.dart` and add a new `QuizCategory` in the `getCategories()` method.

### Adding New Quizzes

Create a new quiz method (e.g., `_getYourQuizzes()`) and add questions following the existing pattern.

## Color Theme

The app uses Google's official brand colors:
- Blue: `#4285F4`
- Red: `#DB4437`
- Yellow: `#F4B400`
- Green: `#0F9D58`

## License

This project is open source and available under the MIT License.
