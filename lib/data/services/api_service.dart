import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart' as model;

class ApiService {
  final supabase = Supabase.instance.client;

  /// Login using Supabase Auth
  Future<model.User> login(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user != null) {
      return model.User(
        id: user.id,
        email: user.email ?? '',
        name: user.userMetadata?['name'] ?? '',
        avatar: user.userMetadata?['avatar_url'],
        createdAt: DateTime.tryParse(user.createdAt ?? '') ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } else {
      throw Exception('Invalid email or password');
    }
  }

  /// Logout using Supabase Auth
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  /// (Optional) You can implement getUserProfile and updateUserProfile using Supabase as needed
} 