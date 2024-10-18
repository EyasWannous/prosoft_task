import 'package:prosoft_task/api/authentication/authentication_client.dart';
import 'package:prosoft_task/api/authentication/i_authentication_repository.dart';
import 'package:prosoft_task/api/authentication/models/user_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  const AuthenticationRepository({
    required this.client,
    required SharedPreferences plugin,
  }) : _plugin = plugin;

  final AuthenticationClient client;
  final SharedPreferences _plugin;

  @override
  Future<UserResult?> login({
    required String username,
    required String password,
  }) async {
    final result = await client.login(username, password);
    if (result == null) return null;

    await _plugin.setString('token', result.token!);

    return result;
  }

  @override
  Future<String?> checkLoggedIn() async {
    return _plugin.getString('token');
  }

  @override
  Future<void> logOut() => _plugin.remove('token');

  @override
  Future<String?> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }
}
