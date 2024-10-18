import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prosoft_task/api/authentication/models/user.dart';
import 'package:prosoft_task/api/authentication/models/user_result.dart';

class AuthenticationClient {
  AuthenticationClient({
    http.Client? httpClient,
    this.baseUrl = 'https://dummyjson.com/auth',
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<UserResult?> login(String username, String password) async {
    try {
      final loginRequest = Uri.parse('$baseUrl/login');

      final user = User(username: username, password: password).toJson();

      final response = await httpClient.post(
        loginRequest,
        body: user,
      );

      if (response.statusCode == 200) {
        return UserResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
