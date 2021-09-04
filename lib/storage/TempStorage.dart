import 'package:shared_preferences/shared_preferences.dart';

class TempStorage {
  static const tokenKey = "token";

  static const user_id = "user id";
  static const rid = "registration id";
  static const first_name = "first name";
  static const last_name = "last name";
  static const email = "email";
  static const course = "course";
  static const branch = "branch";
  static const semester = "semester";
  static const personal_phoneNo = "personal phone number";
  static const parent_phoneNo = "parents phone number";

  //get token
  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(tokenKey) ?? "";
  }

  //set token
  static setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(tokenKey, token);
  }

  //get student id
  static Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(user_id) ?? "";
  }

  //set student id
  static setUserId(String userid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(user_id, userid);
  }

  //get registration id
  static Future<String> getRid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(rid) ?? "";
  }

  //set registration id
  static setRid(String registrationId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(rid, registrationId);
  }

  //get first name
  static Future<String> getFirstName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(first_name) ?? "";
  }

  //set first name
  static setFirstName(String _firstname) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(first_name, _firstname);
  }

  //get last name
  static Future<String> getLastName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(last_name) ?? "";
  }

  //set last name
  static setLastName(String _lastname) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(last_name, _lastname);
  }

  //get email
  static Future<String> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(email) ?? "";
  }

  //set email
  static setEmail(String _email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(email, _email);
  }

  //get course
  static Future<String> getCourse() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(course) ?? "";
  }

  //set course
  static setCourse(String _course) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(course, _course);
  }

  //get branch
  static Future<String> getBranch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(branch) ?? "";
  }

  //set branch
  static setBranch(String _branch) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(branch, _branch);
  }

  //get semester
  static Future<String> getSemester() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(semester) ?? "";
  }

  //set semester
  static setSemester(String _semester) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(semester, _semester);
  }

  //get personal phone number
  static Future<String> getPersonalNo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(personal_phoneNo) ?? "";
  }

  //set personal phone number
  static setPersonalNo(String _personalNo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(personal_phoneNo, _personalNo);
  }

  //get parents phone number
  static Future<String> getParentsNo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(parent_phoneNo) ?? "";
  }

  //set parents phone number
  static setParentsNo(String _parentsNo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(parent_phoneNo, _parentsNo);
  }

  //clear all data in shared preferences
  static removePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(tokenKey);
    preferences.remove(user_id);
    preferences.remove(rid);
    preferences.remove(first_name);
    preferences.remove(last_name);
    preferences.remove(email);
    preferences.remove(branch);
    preferences.remove(course);
    preferences.remove(semester);
    preferences.remove(personal_phoneNo);
    preferences.remove(parent_phoneNo);
  }
}
