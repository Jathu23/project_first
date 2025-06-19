import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/app_theme.dart';
import '../data/repositories/user_repository.dart';
import '../presentation/bloc/auth/auth_bloc.dart';
import '../presentation/bloc/auth/auth_event.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              userRepository: context.read<UserRepository>(),
            )..add(CheckAuthStatus()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Project App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRoutes.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
} 