import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionName = 'users';

  CollectionReference _ref;

  UserRepositoryImpl() {
    _ref = _db.collection(collectionName);
  }

  CollectionReference reference() => _ref;

  @override
  // ignore: missing_return
  Future<String> onboardUser(uid, {Map<String, dynamic> data}) async {
    try {
      if (await _shouldOnboard(uid)) {
        await _ref.doc(uid).set(data);
        return data['email'];
      }
    } catch (e) {
      log('[onboardUser] : $e');
      return null;
    }
  }

  Future<bool> _shouldOnboard(String uid) async {
    var doc = await _ref.doc(uid).get();
    return !doc.exists;
  }

  @override
  Future<UserDetail> fetchUserDetails(String uid) async {
    var doc = await _ref.doc(uid).get();
    return UserDetail.fromMap(doc.data())?.copyWith(uid: uid);
  }
}
