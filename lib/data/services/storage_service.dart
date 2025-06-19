import 'dart:convert';
import '../models/user_model.dart';

class StorageService {
  // Singleton pattern
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  // In-memory storage for demo purposes
  // In a real app, you would use SharedPreferences, Hive, or other storage solutions
  static final Map<String, dynamic> _storage = {};

  // Storage keys
  static const String _userKey = 'user';
  static const String _tokenKey = 'token';
  static const String _isLoggedInKey = 'is_logged_in';

  /// Save user data to storage
  Future<void> saveUser(User user) async {
    _storage[_userKey] = user.toJson();
  }

  /// Get user data from storage
  User? getUser() {
    final userData = _storage[_userKey];
    if (userData != null) {
      return User.fromJson(userData);
    }
    return null;
  }

  /// Save authentication token
  Future<void> saveToken(String token) async {
    _storage[_tokenKey] = token;
  }

  /// Get authentication token
  String? getToken() {
    return _storage[_tokenKey];
  }

  /// Save login status
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    _storage[_isLoggedInKey] = isLoggedIn;
  }

  /// Get login status
  bool isLoggedIn() {
    return _storage[_isLoggedInKey] ?? false;
  }

  /// Clear all stored data (logout)
  Future<void> clearAll() async {
    _storage.clear();
  }

  /// Clear specific data
  Future<void> clearUser() async {
    _storage.remove(_userKey);
    _storage.remove(_tokenKey);
    _storage.remove(_isLoggedInKey);
  }
} 