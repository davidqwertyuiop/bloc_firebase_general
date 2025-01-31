
class LogInFailure implements Exception {
    final String message;
    const LogInFailure([this.message = 'Login failed']);

    factory LogInFailure.fromCode(String code) {
      switch (code) {
        case 'user-not-found':
          return const LogInFailure('No user found with this email');
        case 'wrong-password':
          return const LogInFailure('Incorrect password');
        case 'user-disabled':
          return const LogInFailure('User has been disabled');
        case 'too-many-requests':
          return const LogInFailure('Too many requests. Try again later');
        case 'operation-not-allowed':
          return const LogInFailure('Operation not allowed');
        default:
          return const LogInFailure();
      }
    }
  }

    class LogOutFailure implements Exception {}