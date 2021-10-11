part of '../services.dart';

class ServicePreferances {
  static ServicePreferances instance = ServicePreferances();
  Future saveData(String? key, String? json) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key!, json!);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final datane = prefs.getString('token');
    return datane;
  }

  Future<User?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final datane = prefs.getString('userData');
    return datane == null ? null : User.fromJson(json.decode(datane));
  }
}
