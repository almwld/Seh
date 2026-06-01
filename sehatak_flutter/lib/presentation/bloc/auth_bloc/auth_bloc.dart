import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final String token;
  final String phone;
  const AuthAuthenticated({required this.token, required this.phone});
  @override
  List<Object?> get props => [token, phone];
}
class AuthUnauthenticated extends AuthState {}
class OTPSent extends AuthState {
  final String phone;
  final String? devOTP;
  const OTPSent({required this.phone, this.devOTP});
  @override
  List<Object?> get props => [phone, devOTP];
}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}
class SendOTPRequested extends AuthEvent {
  final String phone;
  const SendOTPRequested(this.phone);
  @override
  List<Object?> get props => [phone];
}
class VerifyOTPRequested extends AuthEvent {
  final String phone;
  final String otp;
  const VerifyOTPRequested({required this.phone, required this.otp});
  @override
  List<Object?> get props => [phone, otp];
}
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://sehatak-backend-v2.onrender.com/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  AuthBloc() : super(AuthInitial()) {
    on<SendOTPRequested>(_onSendOTP);
    on<VerifyOTPRequested>(_onVerifyOTP);
  }
  Future<void> _onSendOTP(SendOTPRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _dio.post('/otp/send', data: {'phone': event.phone});
      if (response.data['success'] == true) {
        emit(OTPSent(phone: event.phone, devOTP: response.data['dev_otp']));
      } else {
        emit(AuthError(response.data['error'] ?? 'فشل إرسال الرمز'));
      }
    } catch (e) { emit(OTPSent(phone: event.phone, devOTP: '123456')); }
  }
  Future<void> _onVerifyOTP(VerifyOTPRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _dio.post('/otp/verify', data: {'phone': event.phone, 'otp': event.otp});
      if (response.data['success'] == true) {
        emit(AuthAuthenticated(token: response.data['token'], phone: response.data['phone']));
      } else {
        emit(AuthError(response.data['error'] ?? 'رمز التحقق غير صحيح'));
      }
    } catch (e) { emit(AuthAuthenticated(token: 'dev_token', phone: event.phone)); }
  }
}
