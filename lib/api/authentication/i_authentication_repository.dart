import 'package:prosoft_task/api/authentication/models/user_result.dart';

abstract class IAuthenticationRepository {
  const IAuthenticationRepository();

  Future<UserResult?> login({
    required String username,
    required String password,
  });

  Future<String?> checkLoggedIn();

  Future<void> logOut();

  Future<String?> refresh();
}
