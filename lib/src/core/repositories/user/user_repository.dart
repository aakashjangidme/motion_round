import '../../models/user_model.dart';

abstract class UserRepository {
  Future<String> onboardUser(uid, {Map<String, dynamic> data});
  Future<UserDetail> fetchUserDetails(String uid);
}
