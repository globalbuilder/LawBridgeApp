import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/utils/messages.dart';
import '../../../../core/widgets/exit_confirmation.dart';
import '../../../../app_router.dart';
import '../blocs/accounts_bloc.dart';
import '../blocs/accounts_event.dart';
import '../blocs/accounts_state.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _password = "";

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AccountsBloc>().add(LoginEvent(_username, _password));
    }
  }

  Future<bool> _onWillPop() async {
    final shouldExit = await showExitConfirmationDialog(context);
    if (shouldExit) exitApp();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppLogo(size: 100),
                    const SizedBox(height: 20),
                    Text(
                      "Welcome Back!",
                      style: textTheme.headlineMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), 
                      ),
                      elevation: 6,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextField(
                                label: "Username",
                                icon: Icons.person,
                                validator: (value) =>
                                    (value == null || value.trim().isEmpty) ? "Please enter your username" : null,
                                onSaved: (value) => _username = value!.trim(),
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: "Password",
                                icon: Icons.lock,
                                obscureText: true,
                                validator: (value) =>
                                    (value == null || value.isEmpty) ? "Please enter your password" : null,
                                onSaved: (value) => _password = value!,
                              ),
                              const SizedBox(height: 24),
                              BlocConsumer<AccountsBloc, AccountsState>(
                                listener: (context, state) {
                                  if (state.status == AccountsStatus.error && state.errorMessage != null) {
                                    MessageUtils.showErrorMessage(context, state.errorMessage!);
                                  }
                                  if (state.status == AccountsStatus.authenticated && state.user != null) {
                                    MessageUtils.showSuccessMessage(context, "Login successful!");
                                    Navigator.pushReplacementNamed(context, AppRouter.home);
                                  }
                                },
                                builder: (context, state) {
                                  final isLoading = state.status == AccountsStatus.loading;
                                  return CustomButton(
                                    label: isLoading ? "Logging in..." : "Login",
                                    onPressed: isLoading ? null : _submit,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.register),
                      child: Text(
                        "Don't have an account? Register",
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
