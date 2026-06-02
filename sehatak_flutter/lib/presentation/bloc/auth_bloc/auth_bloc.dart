import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/services/firebase_service.dart';
import '../../../data/models/user_models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}
class AppStarted extends AuthEvent {
  @override List<Object?> get props => [];
}
class LoginWithEmail extends AuthEvent {
  final String email, password;
  const LoginWithEmail({required this.email, required this.password});
  @override List<Object?> get props => [email, password];
}
class RegisterWithEmail extends AuthEvent {
  final String name, email, phone, password;
  const RegisterWithEmail({required this.name, required this.email, required this.phone, required this.password});
  @override List<Object?> get props => [name, email, phone, password];
}
class Logout extends AuthEvent {
  @override List<Object?> get props => [];
}

abstract class AuthState extends Equatable {
  const AuthState();
}
class AuthInitial extends AuthState {
  @override List<Object?> get props => [];
}
class AuthLoading extends AuthState {
  @override List<Object?> get props => [];
}
class Authenticated extends AuthState {
  final UserModel user;
  const Authenticated(this.user);
  @override List<Object?> get props => [user];
}
class Unauthenticated extends AuthState {
  @override List<Object?> get props => [];
}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override List<Object?> get props => [message];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService _fb = FirebaseService();

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginWithEmail>(_onLogin);
    on<RegisterWithEmail>(_onRegister);
    on<Logout>(_onLogout);
  }

  void _onAppStarted(AppStarted e, Emitter<AuthState> emit) {
    if (_fb.currentUser != null) {
      emit(Authenticated(UserModel(id: _fb.currentUser!.uid, email: _fb.currentUser!.email)));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogin(LoginWithEmail e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _fb.auth.signInWithEmailAndPassword(email: e.email.trim(), password: e.password);
      emit(Authenticated(UserModel(id: _fb.auth.currentUser!.uid, email: e.email)));
    } on FirebaseAuthException catch (ex) {
      emit(AuthError(_msg(ex.code)));
    } catch (ex) {
      emit(AuthError('تأكد من اتصال الإنترنت'));
    }
  }

  Future<void> _onRegister(RegisterWithEmail e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final cred = await _fb.auth.createUserWithEmailAndPassword(email: e.email.trim(), password: e.password);
      await _fb.userDoc(cred.user!.uid).set({
        'id': cred.user!.uid, 'email': e.email, 'phone': e.phone,
        'fullName': e.name, 'role': 'patient', 'createdAt': FieldValue.serverTimestamp(),
      });
      emit(Authenticated(UserModel(id: cred.user!.uid, email: e.email, fullName: e.name)));
    } on FirebaseAuthException catch (ex) {
      emit(AuthError(_msg(ex.code)));
    } catch (ex) {
      emit(AuthError('تأكد من اتصال الإنترنت'));
    }
  }

  Future<void> _onLogout(Logout e, Emitter<AuthState> emit) async {
    await _fb.auth.signOut();
    emit(Unauthenticated());
  }

  String _msg(String code) {
    switch (code) {
      case 'invalid-email': return 'إيميل غير صالح';
      case 'user-not-found': return 'مستخدم غير موجود';
      case 'wrong-password': return 'كلمة مرور خاطئة';
      case 'email-already-in-use': return 'الإيميل مستخدم مسبقاً';
      case 'weak-password': return 'كلمة مرور ضعيفة';
      case 'network-request-failed': return 'لا يوجد اتصال';
      default: return 'خطأ: $code';
    }
  }
}
