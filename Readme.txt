Codebase Assignment
A Flutter application demonstrating state management, API integration, and a premium UI. This project fetches a list of users from the ReqRes API, implements pagination with infinite scrolling, caching with Hive, and supports features like search and error handling.

Table of Contents
Features

Architecture

Installation

Usage

Testing

Dependencies

License

Features
User List Screen:

Displays users with their profile pictures, names, and email addresses.

Implements infinite scrolling to load users in batches (pagination).

Responsive UI using flutter_screenutil.

User Detail Screen:

Displays detailed information for a selected user.

Premium iOS-styled UI using Cupertino widgets.

Search Functionality:

Filter users by name with robust handling of spaces and special characters.

Error Handling:

Shows a loading indicator during API calls.

Displays friendly error messages when there's no internet connection or API failures.

Offers a retry option for error states.

Data Caching:

Uses Hive for offline caching.

Automatically refreshes cached data if it becomes outdated.

Architecture
The project follows a Clean Architecture approach with three layers:

Domain Layer:
Contains business logic, use cases, and entities (e.g., User).

Data Layer:
Responsible for API calls (using Dio), data models, and caching with Hive.

Data Sources: e.g., UserRemoteDataSource

Repositories: e.g., UserRepositoryImpl

Presentation Layer:
Manages the UI and state management using Provider.

Screens: e.g., UserListScreen, UserDetailScreen

Providers: e.g., UserProvider

Dependency injection is implemented using GetIt.

Installation
Clone the Repository:

bash
Copy
git clone https://github.com/your_username/codebase_assignment.git
cd codebase_assignment
Install Dependencies:

Make sure you have Flutter installed. Then, run:

bash
Copy
flutter pub get
Configure Hive:

Hive is automatically initialized in main.dart. No additional configuration is required.

Usage
To run the app:

bash
Copy
flutter run
This will launch the app on the connected device or emulator.

Testing
The project includes widget and API tests.

Run All Tests:

bash
Copy
flutter test
Run a Specific Test File:

bash
Copy
flutter test test/user_list_screen_test.dart
Note on Network Images in Tests
This project uses the network_image_mock package to intercept network image calls during tests.

Dependencies
Flutter

Provider for state management.

Dio for networking.

GetIt for dependency injection.

Hive and Hive Flutter for local caching.

flutter_screenutil for responsive UI.

network_image_mock for testing network images.

Cupertino Widgets for an iOS look.

License
This project is licensed under the MIT License - see the LICENSE file for details.