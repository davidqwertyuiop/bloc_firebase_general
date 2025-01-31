import 'package:bloc_firebase_general/Data/Respositories/authentication/goggle.dart';
import 'package:bloc_firebase_general/Data/Respositories/authentication/passwordresetauth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' as isweb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'applesigninauth.dart';
import 'loginauth.dart';
import 'signupauth.dart';

class AuthRepo {
  final  firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepo({firebase_auth.FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn, SignInWithApple? appleSignIn }):
  
    _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
    _googleSignIn = googleSignIn ?? GoogleSignIn();

    // This getter is used to check if the app is running on the web
    @visibleForTesting
    bool get isWeb => isweb.kIsWeb;


    // This method is used to authenticate the user 
  Stream<firebase_auth.User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        throw Exception('User is not authenticated');
      }
      return firebaseUser;
    });
  }

  //This method is used to sign up the user with email and password
  Future<firebase_auth.User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpFailure.fromCode(e.code);
    }catch(e){
      throw const SignUpFailure();
    }
  }

  // This method is used to sign in the user with email and password
  Future<firebase_auth.User?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInFailure.fromCode(e.code);
    }catch(e){
      throw const LogInFailure();
    }
  }

  //This method shows the user the option to sign in with google
  Future<void> signInWithGoogle() async{
  try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }
      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw GoogleSignInFailure.fromCode(e.code);
    } catch (_) {
      throw const GoogleSignInFailure();
    }
  }

  //This method is to sign in with apple
  Future<void>signInWithApple() async{
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = firebase_auth.OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await _firebaseAuth.signInWithCredential(oauthCredential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AppleSignInFailure.fromCode(e.code);
    } catch (_) {
      throw const AppleSignInFailure();
    }
  }

// This method is used to sign out the user
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        if (!isWeb) _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
  // This method is used to reset the password of the user
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw PasswordResetFailure.fromCode(e.code);
    } catch (_) {
      throw const PasswordResetFailure();
    }
  }
}