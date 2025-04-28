Flutter Firebase Google Sign-In Demo


This project demonstrates how to set up Firebase Authentication with Google Sign-In in a Flutter application.





🔥 Firebase Setup Instructions



Go to Firebase Console.

Create a new project (e.g., flutter_google_auth).


Add an Android app:

Provide your app's package name.

Download the google-services.json file.

Place it inside android/app/ folder.

In android/build.gradle, add:


dependencies {
  classpath 'com.google.gms:google-services:4.3.15' // or latest
}


In android/app/build.gradle, add:

apply plugin: 'com.google.gms.google-services'



Enable Google Sign-In from Authentication > Sign-In method in Firebase Console.


Add required dependencies in pubspec.yaml:

dependencies:
  firebase_core: ^2.24.0
  firebase_auth: ^4.10.0
  google_sign_in: ^6.2.1




Run:

flutter pub get

🛠 Code Overview

Firebase Initialization



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

Google Sign-In Implementation

final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken,
  idToken: googleAuth.idToken,
);

await FirebaseAuth.instance.signInWithCredential(credential);

📋 Git Commit History

The Git commit messages follow a clean and logical structure:

chore: initialize Flutter project

chore: add Firebase to project

feat: initialize Firebase in main.dart

feat: implement Google Sign-In with Firebase Auth

docs: add README.md with Firebase setup instructions

🚀 Project Structure

lib/
 ├── main.dart
 ├── authentication_page.dart
README.md

⚡ How to Run

flutter pub get
flutter run