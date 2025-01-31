
class GoogleSignInFailure implements Exception {
  final String message;
  const GoogleSignInFailure([this.message = 'Google sign in failed']);

  factory GoogleSignInFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const GoogleSignInFailure('Account exists with different credentials');
      case 'invalid-credential':
        return const GoogleSignInFailure('Invalid credentials');
      case 'operation-not-allowed':
        return const GoogleSignInFailure('Operation not allowed');
      case 'user-disabled':
        return const GoogleSignInFailure('User has been disabled');
      case 'user-not-found':
        return const GoogleSignInFailure('No user found with this email');
      case 'wrong-password':
        return const GoogleSignInFailure('Incorrect password');
      case 'invalid-verification-code':
        return const GoogleSignInFailure('Invalid verification code');
      case 'invalid-verification-id':
        return const GoogleSignInFailure('Invalid verification ID');
      default:
        return const GoogleSignInFailure();
    }
  }
}
