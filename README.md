# Codebase Assignment

A Flutter application demonstrating state management, API integration, data caching, responsive UI design, and error handling. This project fetches a list of users from the ReqRes API, implements infinite scrolling with pagination, and presents a premium iOS-style UI using Cupertino widgets. Data is cached locally using Hive, and the app includes robust error handling and responsive design via flutter_screenutil.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Dependencies](#dependencies)
- [License](#license)

## Features

- **User List Screen:**
    - Displays a list of users with profile images, names, and email addresses.
    - Implements infinite scrolling using API pagination (fetches 10 users per page).
    - Includes pull-to-refresh functionality.
    - Contains a responsive search bar with robust handling of spaces and special characters.

- **User Detail Screen:**
    - Shows detailed information for a selected user (profile image, name, email, and phone).
    - Uses a premium iOS-styled UI with Cupertino widgets and Hero animations for smooth transitions.

- **Data Caching:**
    - Uses Hive for offline caching.
    - Automatically refreshes cached data if it becomes outdated (e.g., after one hour).

- **Error Handling:**
    - Displays a loading indicator during API calls.
    - Implements a timeout mechanism to handle slow API responses.
    - Provides friendly error messages for connectivity issues and other errors with a retry option.

- **Responsive Design:**
    - Uses [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) to ensure a consistent layout across multiple device sizes.

## Architecture

The project follows a Clean Architecture approach divided into three main layers:

- **Domain Layer:**  
  Contains business logic, use cases, and entities.
    - Example: The `User` entity and the `GetUsers` use case.

- **Data Layer:**  
  Handles API calls using Dio, data models, caching with Hive, and repository implementations.
    - Example: `UserRemoteDataSource` and `UserRepositoryImpl`.

- **Presentation Layer:**  
  Manages the UI and state with Provider.
    - Screens: `UserListScreen` and `UserDetailScreen`.
    - Providers: `UserProvider` for fetching data, managing search, caching, and error handling.

Dependency injection is managed using [GetIt](https://pub.dev/packages/get_it).

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/virendrarana/codebase_assignment.git
   cd codebase_assignment
Install Dependencies:

Make sure you have Flutter installed. Then, run:

bash
Copy
flutter pub get
Configure Hive (Caching):

Hive is initialized in main.dart and the necessary adapters are registered automatically. No additional configuration is required.

Usage
To run the application:

bash
Copy
flutter run
This command launches the app on your connected device or emulator.

Testing
The project includes widget tests and API tests.

Run All Tests:

bash
Copy
flutter test
Run a Specific Test File:

bash
Copy
flutter test test/user_list_screen_test.dart
Note on Testing Network Images
This project uses network_image_mock to intercept network image calls during tests. This prevents test failures due to HTTP errors when loading images.

Dependencies
Flutter

Provider for state management.

Dio for networking.

GetIt for dependency injection.

Hive & Hive Flutter for local data caching.

flutter_screenutil for responsive UI design.

network_image_mock for testing network images.

Cupertino Widgets for a premium iOS-style UI.

