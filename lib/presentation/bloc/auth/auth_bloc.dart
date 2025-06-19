import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../../app/routes.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('AuthBloc: Login requested for email: ${event.email}');
    emit(AuthLoading());
    
    try {
      final user = await _userRepository.login(event.email, event.password);
      print('AuthBloc: Login successful for user: ${user.name}');
      emit(Authenticated(user));
      // Notify router to refresh
      AuthNotifier().notify();
    } catch (e) {
      print('AuthBloc: Login failed with error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('AuthBloc: Logout requested');
    emit(AuthLoading());
    
    try {
      await _userRepository.logout();
      print('AuthBloc: Logout successful');
      emit(Unauthenticated());
      // Notify router to refresh
      AuthNotifier().notify();
    } catch (e) {
      print('AuthBloc: Logout failed with error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    print('AuthBloc: Checking auth status');
    emit(AuthLoading());
    
    try {
      if (_userRepository.isLoggedIn()) {
        final user = _userRepository.getCurrentUser();
        if (user != null) {
          print('AuthBloc: User is logged in: ${user.name}');
          emit(Authenticated(user));
          // Notify router to refresh
          AuthNotifier().notify();
        } else {
          print('AuthBloc: User is not logged in (no user data)');
          emit(Unauthenticated());
        }
      } else {
        print('AuthBloc: User is not logged in');
        emit(Unauthenticated());
      }
    } catch (e) {
      print('AuthBloc: Check auth status failed with error: $e');
      emit(AuthError(e.toString()));
    }
  }
} 