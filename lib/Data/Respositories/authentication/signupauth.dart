
class SignUpFailure implements Exception {
  final String message;
 const SignUpFailure([this.message = 'Sign up failed']);
 
 factory SignUpFailure.fromCode(String code) {
   switch (code) {
      case 'invalid-email':
        return const SignUpFailure('Email is not valid or badly formatted');
     case 'operation-not-allowed':
       return const SignUpFailure('Operation not allowed');
     case 'email-already-in-use':
       return const SignUpFailure('Email already in use');
     case 'weak-password':
       return const SignUpFailure('Weak password');
     default:
       return const SignUpFailure();
   }
 }
}

