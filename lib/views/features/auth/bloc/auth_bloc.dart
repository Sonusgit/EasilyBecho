import 'package:easilybecho/core/data/services/api_response.dart';
import 'package:easilybecho/views/features/auth/bloc/auth_event.dart';
import 'package:easilybecho/views/features/auth/bloc/auth_state.dart';
import 'package:easilybecho/views/features/auth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(AuthState.initial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
    on<LogoutEvent>(_onLogout);
    on<ResetAuthEvent>(_onReset);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginResponse: ApiResponse.loading()));
    final res = await _authRepo.login(event.request);
    emit(state.copyWith(loginResponse: res));
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signupResponse: ApiResponse.loading()));
    final res = await _authRepo.signup(event.request);
    emit(state.copyWith(signupResponse: res));
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(logoutResponse: ApiResponse.loading()));
    final res = await _authRepo.logout();
    emit(state.copyWith(logoutResponse: res));
  }

  void _onReset(ResetAuthEvent event, Emitter<AuthState> emit) {
    emit(AuthState.initial());
  }
}
