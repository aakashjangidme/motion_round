import 'package:firebase_auth/firebase_auth.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

abstract class AuthService {
  Status get status;

  /// Returns the currently authenticated user object.
  User get currentUser;

  Future<void> onAuthStateChanged(User firebaseUser);

  /// Returns email, if login succesful.
  Future<String> singInWithEmailPass(String email, String password);

  /// Returns email, if registration succesful.
  Future<String> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
    String contact,
    String dob,
  );

  /// Sends the password reset email
  Future<void> sendPasswordResetEmail(String email);

  /// Logs out the currently authenticated user.
  Future<void> signOut();
}
