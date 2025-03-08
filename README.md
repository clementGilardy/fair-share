# Fair Share

A Flutter application that helps distribute expenses between two people based on their respective incomes. The app follows the principle that the person with higher income should contribute proportionally more to shared expenses.

## Features

- Input and store income information for two people
- Enter any expense amount to split
- Automatically calculate fair distribution based on income ratio
- Simple and intuitive user interface
- Instant results with clear visualization

## How It Works

The application uses a proportional distribution algorithm:

1. It calculates the ratio of incomes between both individuals
2. When an expense is entered, it divides the amount according to this ratio
3. The person with higher income will pay more, proportional to how much more they earn

## Installation

### Prerequisites

- Flutter SDK 
- Dart SDK 
- Android Studio or VS Code with Flutter extensions

### Getting Started

1. Clone this repository:
   ```
   git clone https://github.com/clementGilardy/toi-moi.git
   ```

2. Navigate to the project directory:
   ```
   cd toi_et_moi
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

## Usage

1. Enter the monthly income for Person 1
2. Enter the monthly income for Person 2
3. Input the expense amount you want to split
4. The app will display how much each person should contribute
5. Optionally, save frequently split expenses for future reference

## Screenshots

[Place screenshots of your application here]

## Technology Stack

- Flutter Framework
- Dart Programming Language
- Provider for State Management
- Shared Preferences for Local Storage

## Contributing

If you'd like to contribute to this project, please fork the repository and create a pull request, or open an issue to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Thanks to everyone who believes in financial fairness in relationships
- Inspired by the concept of equitable distribution of resources