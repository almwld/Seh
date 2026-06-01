import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/user_models/user_model.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}
class LoginRequested extends AuthEvent {
  final String phone, password;
  const LoginRequested({required this.phone, required this.password});
}
class RegisterRequested extends AuthEvent {
  final String fullName, phone, email, password;
  const RegisterRequested({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
  });
}
class LogoutRequested extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();
}
class AuthInitial extends AuthState {
  @override List<Object?> get props => [];
}
class AuthLoading extends AuthState {
  @override List<Object?> get props => [];
}
class AuthAuthenticated extends AuthState {
  final UserModel user;
  const AuthAuthenticated(this.user);
  @override List<Object?> get props => [user];
}
class AuthUnauthenticated extends AuthState {
  @override List<Object?> get props => [];
}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override List<Object?> get props => [message];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogout);
  }

  void _onAppStarted(AppStarted e, Emitter<AuthState> emit) {
    emit(AuthUnauthenticated());
  }

  Future<void> _onLoginRequested(LoginRequested e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    
    emit(AuthAuthenticated(UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      phone: e.phone,
      fullName: 'مستخدم صحتك',
      email: '${e.phone}@sehatak.com',
    )));
  }

  Future<void> _onRegisterRequested(RegisterRequested e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    
    emit(AuthAuthenticated(UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      phone: e.phone,
      fullName: e.fullName,
      email: e.email,
    )));
  }

  Future<void> _onLogout(LogoutRequested e, Emitter<AuthState> emit) async {
    emit(AuthUnauthenticated());
  }
}
