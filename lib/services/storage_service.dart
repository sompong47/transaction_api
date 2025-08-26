import 'dart:convert';
import 'package:hive/hive.dart';

class StorageService {
  static const String _boxName = 'auth_box';
  static const String _tokenKey = 'access_token';
  static const String _userKey = 'user_data';
  
  late Box _box;

  // Initialize Hive box
  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  // Save token
  Future<void> saveToken(String token) async {
    await _box.put(_tokenKey, token);
  }

  // Get token
  String? getToken() {
    return _box.get(_tokenKey);
  }

  // Delete token
  Future<void> deleteToken() async {
    await _box.delete(_tokenKey);
  }

  // Check if token exists
  bool hasToken() {
    return _box.containsKey(_tokenKey);
  }

  // Save user data
  Future<void> saveUser(Map<String, dynamic> userData) async {
    await _box.put(_userKey, jsonEncode(userData));
  }

  // Get user data
  Map<String, dynamic>? getUser() {
    final userJson = _box.get(_userKey);
    if (userJson != null) {
      return jsonDecode(userJson);
    }
    return null;
  }

  // Delete user data
  Future<void> deleteUser() async {
    await _box.delete(_userKey);
  }

  // Check if user data exists
  bool hasUser() {
    return _box.containsKey(_userKey);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _box.clear();
  }
}