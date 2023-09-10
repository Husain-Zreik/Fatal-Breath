// ignore_for_file: invalid_use_of_visible_for_testing_member

import "package:fatal_breath_frontend/enums/local.types.dart";
import "package:shared_preferences/shared_preferences.dart";

Future<void> setlocal({
  required LocalTypes type,
  required String key,
  required dynamic value,
}) async {
  // SharedPreferences.setMockInitialValues({key: value});

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (type == LocalTypes.Int) {
    await prefs.setInt(key, value);
  } else if (type == LocalTypes.Double) {
    await prefs.setDouble(key, value);
  } else if (type == LocalTypes.String) {
    await prefs.setString(key, value);
  } else if (type == LocalTypes.Bool) {
    await prefs.setBool(key, value);
  }
}

dynamic getLocal({
  required LocalTypes type,
  required String key,
}) async {
  // SharedPreferences.setMockInitialValues({});

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  dynamic result;

  if (type == LocalTypes.Int) {
    result = prefs.getInt(key);
  }
  if (type == LocalTypes.Double) {
    result = prefs.getDouble(key);
  }
  if (type == LocalTypes.String) {
    result = prefs.getString(key);
  }
  if (type == LocalTypes.Bool) {
    result = prefs.getBool(key);
  }

  return result;
}
