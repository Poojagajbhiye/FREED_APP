import 'package:shared_preferences/shared_preferences.dart';

class TempStorage {
  static const tokenKey = "token";
  static const user_id = "user id";
  static const rid = "registration id";

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(tokenKey);
    return token!;
  }

  static setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(tokenKey, token);
  }

  static Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userid = preferences.getString(user_id);
    return userid!;
  }

  static setUserId(String userid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(user_id, userid);
  }

  static Future<String> getRid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? registrationId = preferences.getString(rid);
    return registrationId!;
  }

  static setRid(String registrationId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(rid, registrationId);
  }

}
