import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  // Get the current authenticated user
  User? get currentUser => _auth.currentUser;
  
  // Stream of authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Begin interactive sign in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      // If the user cancels the sign-in flow, return null
      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once sign in is complete, retrieve the UserCredential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      // Notify any listeners that the auth state has changed
      notifyListeners();
      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      // Return null if the process failed
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();
      // Sign out from Firebase
      await _auth.signOut();
      // Notify listeners of the sign out
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
      // Rethrow the error for handling upstream
      rethrow;
    }
  }
  
  // Check if user is signed in
  bool isSignedIn() {
    return currentUser != null;
  }
  
  // Get user display name
  String? getUserName() {
    return currentUser?.displayName;
  }
  
  // Get user email
  String? getUserEmail() {
    return currentUser?.email;
  }
  
  // Get user profile picture URL
  String? getUserPhotoUrl() {
    return currentUser?.photoURL;
  }
  
  // Get user ID
  String? getUserId() {
    return currentUser?.uid;
  }
}