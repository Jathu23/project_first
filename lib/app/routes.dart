import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/bloc/auth/auth_bloc.dart';
import '../presentation/bloc/auth/auth_state.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/home/home_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static GoRouter get router => GoRouter(
    initialLocation: login,
    refreshListenable: AuthNotifier(),
    redirect: (context, state) {
      try {
        final authBloc = context.read<AuthBloc>();
        final authState = authBloc.state;
        final isLoggedIn = authState is Authenticated;
        final isLoginRoute = state.matchedLocation == login;

        print('Router redirect - Auth state: ${authState.runtimeType}, isLoggedIn: $isLoggedIn, current route: ${state.matchedLocation}');

        // If user is not logged in and not on login route, redirect to login
        if (!isLoggedIn && !isLoginRoute) {
          print('Router: Redirecting to login');
          return login;
        }

        // If user is logged in and on login route, redirect to home
        if (isLoggedIn && isLoginRoute) {
          print('Router: Redirecting to home');
          return home;
        }

        // No redirect needed
        print('Router: No redirect needed');
        return null;
      } catch (e) {
        print('Router: Error in redirect: $e');
        return login;
      }
    },
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}

class AuthNotifier extends ChangeNotifier {
  static final AuthNotifier _instance = AuthNotifier._internal();
  factory AuthNotifier() => _instance;
  AuthNotifier._internal();

  void notify() {
    notifyListeners();
  }
} 