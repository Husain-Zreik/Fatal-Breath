import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDataSource {
  static Future login(email, password) async {
    final body = {"email": email, "password": password};
    try {
      final response = await sendRequest(
        route: "/auth/login",
        load: body,
        method: RequestMethods.POST,
      );

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("access_token", response.data["token"]);
      // print(response.data["token"]);
      // print("Token saved");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future register(userName, email, password, confirmPassword) async {
    final body = {
      "userName": userName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword
    };
    try {
      try {
        final response = await sendRequest(
          route: "/auth/register",
          load: body,
          method: RequestMethods.POST,
        );

        final prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", response.data["token"]);

        // print("Token saved");
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
