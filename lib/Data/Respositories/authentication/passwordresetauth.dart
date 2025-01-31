class PasswordResetFailure implements Exception {
  final String message;
  const PasswordResetFailure([this.message = 'Password reset failed']);

  factory PasswordResetFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const PasswordResetFailure('Email address is not valid');
      case 'user-not-found':
        return const PasswordResetFailure('No user found with this email');
      case 'user-disabled':
        return const PasswordResetFailure('User has been disabled');
      case 'too-many-requests':
        return const PasswordResetFailure('Too many requests. Try again later');
      case 'operation-not-allowed':
        return const PasswordResetFailure('Operation not allowed');
      default:
        return const PasswordResetFailure();
    }
  }
}