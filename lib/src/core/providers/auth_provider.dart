import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../locator.dart';
import '../constants/constants.dart';
import '../models/user_model.dart';
import '../repositories/user/user_repository.dart';
import '../services/auth/auth_service.dart';
import '../services/dialog/dialog_service.dart';

class AuthProvider with ChangeNotifier implements AuthService {
  //Firebase Auth object
  FirebaseAuth _auth;

  //Default status
  Status _status = Status.Uninitialized;
  ModelStatus _modelStatus = ModelStatus.idle;
  ModelStatus get modelStatus => _modelStatus;

  void _setModel(ModelStatus s) {
    _modelStatus = s;
    notifyListeners();
  }

  @override
  Status get status => _status;

  User _currentUser;
  UserDetail _userDetail;

  UserDetail get userDetails => _userDetail;

  /// Returns currently logged in Firebase User object.
  @override
  User get currentUser => _currentUser;

  Stream<User> get onAuthChanged => _auth.authStateChanges();

  StreamSubscription<User> _authSubsription;

  final _dialogService = locator<DialogService>();
  final _userRepo = locator<UserRepository>();

  AuthProvider() {
    //initialise object
    _auth = FirebaseAuth.instance;

    //listener for authentication changes such as user sign in and sign out
    _authSubsription = _auth.authStateChanges().listen(onAuthStateChanged);
  }

  @override

  ///Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      notifyListeners();
    } else {
      _currentUser = firebaseUser;
      _userDetail = await _customUserFromFirebase(firebaseUser);
      _status = Status.Authenticated;
      notifyListeners();
    }
  }

  Future<UserDetail> _customUserFromFirebase(User firebaseUser) async {
    return _userRepo.fetchUserDetails(firebaseUser.uid);
  }

  @override
  //Method to handle user signing out
  Future<void> signOut() async {
    await _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  //Method for new user registration using email and password
  @override
  Future<String> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
    String contact,
    String dob,
  ) async {
    try {
      // _status = Status.Registering;
      // notifyListeners();
      _setModel(ModelStatus.busy);

      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var e = await _userRepo.onboardUser(
        result.user.uid,
        data: {
          'name': name,
          'email': email,
          'contact': contact,
          'dob': dob,
        },
      );

      /// Prevents auto login after registration.
      await signOut();

      return e;
    } on FirebaseAuthException catch (err) {
      _status = Status.Unauthenticated;

      notifyListeners();
      await _dialogService.showAlertDialog(
        key: Key(err.code),
        title: 'Oops!',
        content: err.message,
        showCancelBUtton: false,
      );

      return null;
    } catch (e) {
      print('Error on the new user registration = ' + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    } finally {
      _setModel(ModelStatus.idle);
    }
  }

  @override
  //Method to handle user sign in using email and password
  Future<String> singInWithEmailPass(String email, String password) async {
    try {
      // _status = Status.Authenticating;
      // notifyListeners();

      _setModel(ModelStatus.busy);
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _userDetail = await _customUserFromFirebase(result.user);
      notifyListeners();

      return result.user.email;
    } on FirebaseAuthException catch (err) {
      _status = Status.Unauthenticated;
      notifyListeners();
      await _dialogService.showAlertDialog(
        key: Key(err.code),
        title: 'Oops!',
        content: err.message,
        showCancelBUtton: false,
      );

      return null;
    } catch (e) {
      print('Error on the sign in = ' + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    } finally {
      _setModel(ModelStatus.idle);
    }
  }

  //Method to handle password reset email
  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _setModel(ModelStatus.busy);

      await _auth.sendPasswordResetEmail(email: email);

      await _dialogService.showAlertDialog(
        key: Key(email),
        title: 'Email Sent!',
        content: 'Please, Check your inbox for a password reset email.',
        showCancelBUtton: false,
        okButtonText: 'Proceed',
      );
      return true;
    } on FirebaseAuthException catch (e) {
      await _dialogService.showAlertDialog(
        key: Key(e.code),
        title: 'Oops!',
        content: e.message,
        showCancelBUtton: false,
        okButtonText: 'OK',
      );
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      _setModel(ModelStatus.idle);
    }
  }

  @override
  void dispose() {
    if (_authSubsription != null) {
      _authSubsription.cancel();
      _authSubsription = null;
    }
    super.dispose();
  }
}
