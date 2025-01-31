
class AppleSignInFailure implements Exception {
  final String message;
  const AppleSignInFailure([this.message = 'Apple sign in failed']);

  factory AppleSignInFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const AppleSignInFailure('Account exists with different credentials');
      case 'invalid-credential':
        return const AppleSignInFailure('Invalid credentials');
      case 'operation-not-allowed':
        return const AppleSignInFailure('Operation not allowed');
      case 'user-disabled':
        return const AppleSignInFailure('User has been disabled');
      case 'user-not-found':
        return const AppleSignInFailure('No user found with this email');
      case 'wrong-password':
        return const AppleSignInFailure('Incorrect password');
      case 'invalid-verification-code':
        return const AppleSignInFailure('Invalid verification code');
      case 'invalid-verification-id':
        return const AppleSignInFailure('Invalid verification ID');
      default:
        return const AppleSignInFailure();
    }
  }
}