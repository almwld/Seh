import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/services/firebase_service.dart';
import '../../../data/models/user_models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}
class AppStarted extends AuthEvent { @override List<Object?> get props => []; }
class LoginWithEmail extends AuthEvent {
  final String email, password;
  const LoginWithEmail({required this.email, required this.password});
  @override List<Object?> get props => [email, password];
}
class LoginWithGoogle extends AuthEvent { @override List<Object?> get props => []; }
class LoginWithApple extends AuthEvent { @override List<Object?> get props => []; }
class LoginWithPhone extends AuthEvent {
  final String phone;
  const LoginWithPhone(this.phone);
  @override List<Object?> get props => [phone];
}
class VerifyPhoneOTP extends AuthEvent {
  final String verificationId, otp;
  const VerifyPhoneOTP({required this.verificationId, required this.otp});
  @override List<Object?> get props => [verificationId, otp];
}
class RegisterWithEmail extends AuthEvent {
  final String name, email, phone, password;
  const RegisterWithEmail({required this.name, required this.email, required this.phone, required this.password});
  @override List<Object?> get props => [name, email, phone, password];
}
class ResetPassword extends AuthEvent {
  final String email;
  const ResetPassword(this.email);
  @override List<Object?> get props => [email];
}
class Logout extends AuthEvent { @override List<Object?> get props => []; }

abstract class AuthState extends Equatable {
  const AuthState();
}
class AuthInitial extends AuthState { @override List<Object?> get props => []; }
class AuthLoading extends AuthState { @override List<Object?> get props => []; }
class AuthCodeSent extends AuthState {
  final String verificationId;
  const AuthCodeSent(this.verificationId);
  @override List<Object?> get props => [verificationId];
}
class Authenticated extends AuthState {
  final UserModel user;
  const Authenticated(this.user);
  @override List<Object?> get props => [user];
}
class Unauthenticated extends AuthState { @override List<Object?> get props => []; }
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override List<Object?> get props => [message];
}
class PasswordResetSent extends AuthState { @override List<Object?> get props => []; }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService _fb = FirebaseService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginWithEmail>(_onLogin);
    on<LoginWithGoogle>(_onGoogleLogin);
    on<LoginWithApple>(_onAppleLogin);
    on<LoginWithPhone>(_onLoginPhone);
    on<VerifyPhoneOTP>(_onVerifyOTP);
    on<RegisterWithEmail>(_onRegister);
    on<ResetPassword>(_onResetPassword);
    on<Logout>(_onLogout);
  }

  void _onAppStarted(AppStarted e, Emitter<AuthState> emit) {
    if (_fb.auth.currentUser != null) {
      final u = _fb.auth.currentUser!;
      emit(Authenticated(UserModel(id: u.uid, email: u.email, fullName: u.displayName)));
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

  Future<void> _onGoogleLogin(LoginWithGoogle e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) { emit(Unauthenticated()); return; }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCred = await _fb.auth.signInWithCredential(credential);
      await _saveUserIfNew(userCred);
      final u = userCred.user!;
      emit(Authenticated(UserModel(id: u.uid, email: u.email, fullName: u.displayName)));
    } catch (ex) {
      emit(AuthError('فشل تسجيل الدخول بـ Google'));
    }
  }

  Future<void> _onAppleLogin(LoginWithApple e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final appleProvider = AppleAuthProvider();
      final userCred = await _fb.auth.signInWithProvider(appleProvider);
      await _saveUserIfNew(userCred);
      final u = userCred.user!;
      emit(Authenticated(UserModel(id: u.uid, email: u.email, fullName: u.displayName)));
    } catch (ex) {
      emit(AuthError('فشل تسجيل الدخول بـ Apple'));
    }
  }

  Future<void> _onLoginPhone(LoginWithPhone e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _fb.auth.verifyPhoneNumber(
        phoneNumber: '+967${e.phone}',
        verificationCompleted: (cred) async { await _fb.auth.signInWithCredential(cred); },
        verificationFailed: (ex) => emit(AuthError(ex.message ?? 'خطأ')),
        codeSent: (id, token) => emit(AuthCodeSent(id)),
        codeAutoRetrievalTimeout: (id) {},
      );
    } catch (ex) {
      emit(AuthError('فشل إرسال الرمز'));
    }
  }

  Future<void> _onVerifyOTP(VerifyPhoneOTP e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final cred = PhoneAuthProvider.credential(verificationId: e.verificationId, smsCode: e.otp);
      final userCred = await _fb.auth.signInWithCredential(cred);
      await _saveUserIfNew(userCred);
      final u = userCred.user!;
      emit(Authenticated(UserModel(id: u.uid, phone: u.phoneNumber)));
    } catch (ex) {
      emit(AuthError('رمز التحقق غير صحيح'));
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
      emit(Authenticated(UserModel(id: cred.user!.uid, email: e.email, fullName: e.name, phone: e.phone)));
    } on FirebaseAuthException catch (ex) {
      emit(AuthError(_msg(ex.code)));
    } catch (ex) {
      emit(AuthError('تأكد من اتصال الإنترنت'));
    }
  }

  Future<void> _onResetPassword(ResetPassword e, Emitter<AuthState> emit) async {
    if (e.email.isEmpty) { emit(AuthError('أدخل بريدك الإلكتروني')); return; }
    emit(AuthLoading());
    try {
      await _fb.auth.sendPasswordResetEmail(email: e.email.trim());
      emit(PasswordResetSent());
    } on FirebaseAuthException catch (ex) {
      emit(AuthError(_msg(ex.code)));
    }
  }

  Future<void> _onLogout(Logout e, Emitter<AuthState> emit) async {
    await _googleSignIn.signOut();
    await _fb.auth.signOut();
    emit(Unauthenticated());
  }

  Future<void> _saveUserIfNew(UserCredential cred) async {
    if (cred.additionalUserInfo?.isNewUser ?? false) {
      await _fb.userDoc(cred.user!.uid).set({
        'id': cred.user!.uid, 'email': cred.user!.email,
        'fullName': cred.user!.displayName ?? '', 'role': 'patient',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  String _msg(String code) {
    switch (code) {
      case 'invalid-email': return 'بريد غير صالح';
      case 'user-not-found': return 'مستخدم غير موجود';
      case 'wrong-password': return 'كلمة مرور خاطئة';
      case 'email-already-in-use': return 'البريد مستخدم مسبقاً';
      case 'weak-password': return 'كلمة مرور ضعيفة';
      case 'network-request-failed': return 'لا يوجد اتصال';
      case 'too-many-requests': return 'محاولات كثيرة';
      default: return code;
    }
  }
}
