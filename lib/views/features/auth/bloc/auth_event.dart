import 'package:easilybecho/views/features/auth/models/login_request.dart';
import 'package:easilybecho/views/features/auth/models/signup_request.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginRequest request;
  LoginEvent(this.request);
}

class SignupEvent extends AuthEvent {
  final SignupRequest request;
  SignupEvent(this.request);
}

class LogoutEvent extends AuthEvent {}

class ResetAuthEvent extends AuthEvent {}