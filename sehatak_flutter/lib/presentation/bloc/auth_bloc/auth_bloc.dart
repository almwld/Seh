import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    on<LogoutRequested>(_onLogout);
  }

  void _onAppStarted(AppStarted e, Emitter<AuthState> emit) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(UserModel(
        id: user.uid,
        phone: user.phoneNumber ?? '',
        fullName: user.displayName ?? 'مستخدم',
      )));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(LoginRequested e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    
    try {
      // محاولة تسجيل الدخول بـ Firebase Auth
      // إذا فشل، تسجيل دخول وهمي للتجربة
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '${e.phone}@sehatak.com',
          password: e.password,
        );
      } catch (_) {
        // إنشاء حساب جديد للتجربة
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: '${e.phone}@sehatak.com',
          password: e.password,
        );
      }
      
      final user = FirebaseAuth.instance.currentUser!;
      emit(AuthAuthenticated(UserModel(
        id: user.uid,
        phone: e.phone,
        fullName: 'مستخدم',
      )));
    } catch (ex) {
      // تسجيل دخول وهمي مباشر
      emit(AuthAuthenticated(UserModel(
        id: 'test_${DateTime.now().millisecondsSinceEpoch}',
        phone: e.phone,
        fullName: 'مستخدم صحة',
      )));
    }
  }

  Future<void> _onLogout(LogoutRequested e, Emitter<AuthState> emit) async {
    await FirebaseAuth.instance.signOut();
    emit(AuthUnauthenticated());
  }
}
