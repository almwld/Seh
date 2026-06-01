import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  SharedPreferences? _prefs;

  LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    await init();
    return _prefs!.setString(key, value);
  }

  String? getString(String key) {
    if (_prefs == null) return null;
    return _prefs!.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    await init();
    return _prefs!.setBool(key, value);
  }

  bool? getBool(String key) {
    if (_prefs == null) return null;
    return _prefs!.getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    await init();
    return _prefs!.setInt(key, value);
  }

  int? getInt(String key) {
    if (_prefs == null) return null;
    return _prefs!.getInt(key);
  }

  Future<bool> setDouble(String key, double value) async {
    await init();
    return _prefs!.setDouble(key, value);
  }

  double? getDouble(String key) {
    if (_prefs == null) return null;
    return _prefs!.getDouble(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    await init();
    return _prefs!.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    if (_prefs == null) return null;
    return _prefs!.getStringList(key);
  }

  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    await init();
    return _prefs!.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getObject(String key) {
    if (_prefs == null) return null;
    final String? jsonString = _prefs!.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  Future<bool> remove(String key) async {
    await init();
    return _prefs!.remove(key);
  }

  Future<bool> clear() async {
    await init();
    return _prefs!.clear();
  }

  Future<bool> containsKey(String key) async {
    await init();
    return _prefs!.containsKey(key);
  }

  // Auth specific
  Future<void> setToken(String token) async {
    await setString('auth_token', token);
  }

  String? getToken() {
    return getString('auth_token');
  }

  Future<void> removeToken() async {
    await remove('auth_token');
  }

  Future<void> setRefreshToken(String token) async {
    await setString('refresh_token', token);
  }

  String? getRefreshToken() {
    return getString('refresh_token');
  }

  Future<void> setUserData(Map<String, dynamic> user) async {
    await setObject('user_data', user);
  }

  Map<String, dynamic>? getUserData() {
    return getObject('user_data');
  }

  Future<bool> isLoggedIn() async {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await remove('auth_token');
    await remove('refresh_token');
    await remove('user_data');
  }
}
