import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class UserRepository {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  /// Login user
  Future<User> login(String email, String password) async {
    print('UserRepository: Login called - Email: $email');
    try {
      // Call API to login
      final user = await _apiService.login(email, password);
      print('UserRepository: API login successful for user: ${user.name}');
      
      // Save user data and login status to storage
      await _storageService.saveUser(user);
      await _storageService.saveLoginStatus(true);
      await _storageService.saveToken('mock_token_${user.id}');
      print('UserRepository: User data saved to storage');
      
      return user;
    } catch (e) {
      print('UserRepository: Login failed with error: $e');
      rethrow;
    }
  }

  /// Logout user
  Future<void> logout() async {
    print('UserRepository: Logout called');
    try {
      // Call API to logout
      await _apiService.logout();
      print('UserRepository: API logout successful');
      
      // Clear local storage
      await _storageService.clearUser();
      print('UserRepository: Local storage cleared');
    } catch (e) {
      print('UserRepository: Logout failed with error: $e');
      // Even if API call fails, clear local storage
      await _storageService.clearUser();
      print('UserRepository: Local storage cleared despite API error');
      rethrow;
    }
  }

  /// Get current user from storage
  User? getCurrentUser() {
    final user = _storageService.getUser();
    print('UserRepository: Get current user - ${user?.name ?? 'null'}');
    return user;
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    final isLoggedIn = _storageService.isLoggedIn();
    print('UserRepository: Is logged in - $isLoggedIn');
    return isLoggedIn;
  }

  /// Get user profile from API
  Future<User> getUserProfile() async {
    print('UserRepository: Get user profile called');
    return await _apiService.getUserProfile();
  }

  /// Update user profile
  Future<User> updateUserProfile({
    required String name,
    String? avatar,
  }) async {
    print('UserRepository: Update user profile called - Name: $name');
    final updatedUser = await _apiService.updateUserProfile(
      name: name,
      avatar: avatar,
    );
    
    // Update local storage
    await _storageService.saveUser(updatedUser);
    print('UserRepository: Updated user data saved to storage');
    
    return updatedUser;
  }
} 