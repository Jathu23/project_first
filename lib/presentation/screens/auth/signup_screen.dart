import 'package:flutter/material.dart';
import '../../../core/constants/strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.signup),
      ),
      body: const Center(
        child: Text('Signup Screen - Coming Soon!'),
      ),
    );
  }
} 