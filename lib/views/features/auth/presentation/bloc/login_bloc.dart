import 'package:easilybecho/core/extensions/app_log_print_extention.dart';
import 'package:easilybecho/core/helpers/toast/toast_helper.dart';
import 'package:easilybecho/core/network/error/error_handler.dart';
import 'package:easilybecho/views/features/auth/models/login_request.dart';
import 'package:easilybecho/views/features/auth/presentation/bloc/login_event.dart';
import 'package:easilybecho/views/features/auth/presentation/bloc/login_state.dart';
import 'package:easilybecho/views/features/auth/repo/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  // Email changed
  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  // Password changed
  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  // Toggle password visibility
  void _onPasswordVisibilityToggled(
    LoginPasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  // Login submitted
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isFormValid) {
      ToastHelper.warning(
        title: 'Invalid Input',
        message: 'Please enter valid email and password',
      );
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    "Login attempt - Email: ${event.email}".logInfo(tag: 'LoginBloc');

    try {
      final request = LoginRequest(
        email: event.email,
        password: event.password,
      );

      final response = await _authRepository.login(request);

      if (response == null) {
        "Login failed - No response".logWarning(tag: 'LoginBloc');
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Failed to connect to server',
        ));
        ToastHelper.error(
          title: 'Login Failed',
          message: 'Failed to connect to server',
        );
        return;
      }

      if (response.status.toLowerCase() == 'success' && 
          response.payload != null) {
        "Login successful".logInfo(tag: 'LoginBloc');
        
        emit(state.copyWith(status: LoginStatus.success));
        
        ToastHelper.success(
          title: 'Login Successful',
          message: response.message,
        );
      } else {
        "Login failed - ${response.message}".logWarning(tag: 'LoginBloc');
        
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: response.message,
        ));
        
        ToastHelper.error(
          title: 'Login Failed',
          message: response.message,
        );
      }
    } catch (e, stackTrace) {
      "Login exception".logError(e, stackTrace, tag: 'LoginBloc');
      
      final errorMessage = ErrorHandler.handle(e);
      
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: errorMessage,
      ));
      
      ToastHelper.error(
        title: 'Login Error',
        message: errorMessage,
      );
    }
  }
}