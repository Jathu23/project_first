import 'dart:async';
import '../models/user_model.dart';

class ApiService {
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Mock API delay
  static const Duration _mockDelay = Duration(seconds: 2);

  // Mock credentials for development
  static const String _mockEmail = 'user@example.com';
  static const String _mockPassword = 'password123';

  /// Mock login API call
  /// In a real app, this would make an HTTP request to your backend
  Future<User> login(String email, String password) async {
    print('ApiService: Login attempt - Email: $email, Password: $password');
    print('ApiService: Expected credentials - Email: $_mockEmail, Password: $_mockPassword');
    
    // Simulate network delay
    await Future.delayed(_mockDelay);

    // Validate credentials
    if (email == _mockEmail && password == _mockPassword) {
      print('ApiService: Login successful - credentials match');
      // Return mock user data
      return MockUser.user;
    } else {
      print('ApiService: Login failed - credentials do not match');
      // Throw exception for invalid credentials
      throw Exception('Invalid email or password');
    }
  }

  /// Mock logout API call
  Future<void> logout() async {
    print('ApiService: Logout called');
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In a real app, this would invalidate the session on the server
    // For now, just return successfully
    print('ApiService: Logout successful');
  }

  /// Mock get user profile API call
  Future<User> getUserProfile() async {
    print('ApiService: Get user profile called');
    // Simulate network delay
    await Future.delayed(_mockDelay);
    
    // Return mock user data
    print('ApiService: Returning mock user profile');
    return MockUser.user;
  }

  /// Mock update user profile API call
  Future<User> updateUserProfile({
    required String name,
    String? avatar,
  }) async {
    print('ApiService: Update user profile called - Name: $name, Avatar: $avatar');
    // Simulate network delay
    await Future.delayed(_mockDelay);
    
    // Return updated mock user data
    print('ApiService: Returning updated mock user profile');
    return MockUser.user.copyWith(
      name: name,
      avatar: avatar,
      updatedAt: DateTime.now(),
    );
  }
} 