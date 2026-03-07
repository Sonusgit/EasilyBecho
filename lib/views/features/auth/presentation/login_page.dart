import 'package:easilybecho/core/common/common_buttons.dart';
import 'package:easilybecho/core/common/common_text_tield.dart';
import 'package:easilybecho/core/di/injection.dart';
import 'package:easilybecho/core/utility/const/app_enums.dart';
import 'package:easilybecho/core/validator/validator_helper.dart';
import 'package:easilybecho/views/features/auth/bloc/auth_bloc.dart';
import 'package:easilybecho/views/features/auth/bloc/auth_event.dart';
import 'package:easilybecho/views/features/auth/bloc/auth_state.dart';
import 'package:easilybecho/views/features/auth/models/login_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey            = GlobalKey<FormState>();
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible     = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
          LoginEvent(
            LoginRequest(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            prev.loginResponse.status != curr.loginResponse.status,
        listener: (context, state) {
          final res = state.loginResponse;
          if (res.status == ApiStatus.success) {
            // context.go('/home');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(res.message ?? 'Welcome!')),
            );
          } else if (res.status == ApiStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(res.message ?? 'Login failed.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.loginResponse.status == ApiStatus.loading;

          return Scaffold(
            appBar: AppBar(title: const Text('Login')),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ── Email ─────────────────────────────────────────────
                    CommonTextField(
                      labelText: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.email_outlined),
                      validator: ValidatorHelper.validEmail,
                    ),
                    const SizedBox(height: 16),

                    // ── Password ──────────────────────────────────────────
                    CommonTextField(
                      labelText: 'Password',
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _passwordVisible = !_passwordVisible),
                      ),
                      validator: ValidatorHelper.validPassword,
                    ),
                    const SizedBox(height: 28),

                    // ── Login Button ──────────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      child: CommonBtns.elevatedButton(
                        title: 'Login',
                        isLoading: isLoading,
                        onPressed: () => _onLogin(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}