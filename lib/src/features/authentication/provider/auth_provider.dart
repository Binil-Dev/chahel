import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

// Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password, context) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      toastSucess(context, "Sign up successful.");
      return userCredential;
    } catch (error) {
      toastError(context, "Sign up failed");
      print('Error during sign up: $error');
      return null;
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      toastSucess(context, "Signed up successfully.");
      return userCredential;
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        toastError(context, "No user found for that email.");
      } else if (err.code == 'wrong-password') {
        toastError(context, "Password is invalid.");
      } else {
        toastError(context, "Re-check the email and password.");
      }
    } catch (error) {
      print('Error during sign in: $error');
      return null;
    }
    notifyListeners();
    return null;
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email');
    } catch (error) {
      print('Error sending password reset email: $error');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await auth.signOut();
  }
}
