import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/services/firebase_service.dart';
import '../../../data/models/user_models/user_model.dart';

// ========== EVENTS ==========
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginWithPhoneRequested extends AuthEvent {
  final String phone;
  const LoginWithPhoneRequested(this.phone);
  @override
  List<Object?> get props => [phone];
}

class VerifyOTPRequested extends AuthEvent {
  final String verificationId;
  final String otp;
  const VerifyOTPRequested({required this.verificationId, required this.otp});
  @override
  List<Object?> get props => [verificationId, otp];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  const LoginRequested({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  const RegisterRequested({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });
  @override
  List<Object?> get props => [fullName, email, phone, password];
}

class LogoutRequested extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  const ForgotPasswordRequested(this.email);
}

class ResendOTPRequested extends AuthEvent {
  final String phone;
  const ResendOTPRequested(this.phone);
}

// ========== STATES ==========
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthCodeSent extends AuthState {
  final String verificationId;
  final int? resendToken;
  const AuthCodeSent({required this.verificationId, this.resendToken});
}
class AuthPhoneVerified extends AuthState {
  final bool isNewUser;
  final String phone;
  const AuthPhoneVerified({required this.isNewUser, required this.phone});
}
class AuthAuthenticated extends AuthState {
  final UserModel user;
  const AuthAuthenticated(this.user);
}
class AuthUnauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
class PasswordResetSent extends AuthState {}

// ========== BLOC ==========
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService _firebase = FirebaseService();

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginWithPhoneRequested>(_onLoginWithPhone);
    on<VerifyOTPRequested>(_onVerifyOTP);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
    on<ForgotPasswordRequested>(_onForgotPassword);
    on<ResendOTPRequested>(_onResendOTP);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) {
    if (_firebase.isLoggedIn) {
      final user = _firebase.currentUser!;
      emit(AuthAuthenticated(UserModel(
        id: user.uid,
        phone: user.phoneNumber,
        email: user.email,
      )));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginWithPhone(
    LoginWithPhoneRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _firebase.auth.verifyPhoneNumber(
        phoneNumber: '+967${event.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          final userCred = await _firebase.auth.signInWithCredential(credential);
          await _handleLoginSuccess(userCred, emit);
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthError(_getErrorMsg(e.code)));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(AuthCodeSent(
            verificationId: verificationId,
            resendToken: resendToken,
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(AuthError('فشل إرسال رمز التحقق'));
    }
  }

  Future<void> _onVerifyOTP(
    VerifyOTPRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otp,
      );
      final userCred = await _firebase.auth.signInWithCredential(credential);
      await _handleLoginSuccess(userCred, emit);
    } catch (e) {
      emit(AuthError('رمز التحقق غير صحيح'));
    }
  }

  Future<void> _onLogin(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCred = await _firebase.auth.signInWithEmailAndPassword(
        email: event.email.trim(),
        password: event.password,
      );
      await _handleLoginSuccess(userCred, emit);
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMsg(e.code)));
    }
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCred = await _firebase.auth.createUserWithEmailAndPassword(
        email: event.email.trim(),
        password: event.password,
      );

      await _firebase.userDoc(userCred.user!.uid).set({
        'id': userCred.user!.uid,
        'email': event.email.trim(),
        'phone': event.phone,
        'fullName': event.fullName,
        'role': 'patient',
        'isVerified': true,
        'walletBalance': 0.0,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      });

      final userDoc = await _firebase.userDoc(userCred.user!.uid).get();
      emit(AuthAuthenticated(UserModel.fromFirestore(userDoc)));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMsg(e.code)));
    }
  }

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _firebase.auth.signOut();
    emit(AuthUnauthenticated());
  }

  Future<void> _onForgotPassword(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _firebase.auth.sendPasswordResetEmail(email: event.email.trim());
      emit(PasswordResetSent());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMsg(e.code)));
    }
  }

  Future<void> _onResendOTP(
    ResendOTPRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _firebase.auth.verifyPhoneNumber(
        phoneNumber: '+967${event.phone}',
        verificationCompleted: (credential) async {},
        verificationFailed: (e) {
          emit(AuthError(_getErrorMsg(e.code)));
        },
        codeSent: (verificationId, resendToken) {
          emit(AuthCodeSent(
            verificationId: verificationId,
            resendToken: resendToken,
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      emit(AuthError('فشل إعادة الإرسال'));
    }
  }

  Future<void> _handleLoginSuccess(
    UserCredential userCred,
    Emitter<AuthState> emit,
  ) async {
    final user = userCred.user!;

    await _firebase.userDoc(user.uid).update({
      'lastLogin': FieldValue.serverTimestamp(),
      'deviceToken': await _firebase.messaging.getToken() ?? '',
    });

    final userDoc = await _firebase.userDoc(user.uid).get();

    if (userDoc.exists) {
      emit(AuthAuthenticated(UserModel.fromFirestore(userDoc)));
    } else {
      emit(AuthPhoneVerified(
        isNewUser: true,
        phone: user.phoneNumber ?? '',
      ));
    }
  }

  String _getErrorMsg(String code) {
    switch (code) {
      case 'invalid-phone-number': return 'رقم الهاتف غير صالح';
      case 'user-not-found': return 'المستخدم غير موجود';
      case 'wrong-password': return 'كلمة المرور غير صحيحة';
      case 'email-already-in-use': return 'البريد الإلكتروني مستخدم مسبقاً';
      case 'invalid-email': return 'بريد إلكتروني غير صالح';
      case 'weak-password': return 'كلمة المرور ضعيفة';
      case 'invalid-verification-code': return 'رمز التحقق غير صحيح';
      case 'too-many-requests': return 'طلبات كثيرة جداً، حاول لاحقاً';
      default: return 'حدث خطأ: $code';
    }
  }
}
