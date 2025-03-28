class ErrorHelper {
  static String getFriendlyErrorMessage(String? error) {
    if (error == null || error.isEmpty) {
      return 'Something went wrong. Please try again.';
    }
    final lowerCaseError = error.toLowerCase();
    if (lowerCaseError.contains('socket') ||
        lowerCaseError.contains('no internet') ||
        lowerCaseError.contains('failed host lookup')) {
      return 'No internet connection. Please check your connection and try again.';
    }
    return 'Something went wrong. Please try again later.';
  }
}
