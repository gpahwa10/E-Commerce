import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  //set user email
  static Future<void> setUserEmail(String email) async {
    final prefs = await getPrefs();
    prefs.setString('email', email);
  }
  static Future<void> getUserEmail(String email) async {
    final prefs = await getPrefs();
    prefs.getString('email');
  }

  static Future<void> clearUserEmail(String email) async {
    final prefs = await getPrefs();
    prefs.remove('email');
  }

  //For password
  static Future<String?> getUserPassword() async {
    final prefs = await getPrefs();
    return prefs.getString('userPassword');
  }

  static Future<void> setUserPassword(String userPassword) async {
    final prefs = await getPrefs();
    prefs.setString('userPassword', userPassword);
  }

  static Future<void> clearUserPassword() async {
    final prefs = await getPrefs();
    prefs.remove('userPassword');
  }
  // for token
  static Future<String?> getBearer() async {
    final prefs = await getPrefs();
    return prefs.getString('bearer');
  }

  static Future<void> setBearer(String bearer) async {
    final prefs = await getPrefs();
    prefs.setString('bearer', bearer);
  }

  static Future<void> clearBearer() async {
    final prefs = await getPrefs();
    prefs.remove('bearer');
  }

  // clear all
  static Future<void> clearAll() async {
    final prefs = await getPrefs();
    prefs.clear();
  }
}
