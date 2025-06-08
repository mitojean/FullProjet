import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up/app/modules/auth/forget_password_otp/views/forget_password_page.dart';
import 'package:super_up/app/modules/auth/register/views/register_view.dart';
import 'package:super_up_core/super_up_core.dart';

import '../../../../core/api_service/auth/auth_api_service.dart';
import '../../../../core/api_service/profile/profile_api_service.dart';
import '../../widgets/auth_header.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController(
        GetIt.I.get<AuthApiService>(), GetIt.I.get<ProfileApiService>());
    controller.onInit();
  }

  // Visibility toggle for password field
  bool _obscurePassword = true;

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  // Handle login button press
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      controller.login(context);
    }
  }

  void _navigateToRegister() {
    context.toPage(const RegisterView());
  }

  void _navigateToForgotPassword() {
    context.toPage(ForgetPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    // Define green theme color
    const Color primaryGreen = Colors.green;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if we're on a large screen
        final isLargeScreen = constraints.maxWidth > 600;

        // Calculate the form width based on screen size
        final formWidth = isLargeScreen ? 500.0 : constraints.maxWidth * 0.9;

        return Scaffold(
          // Only show AppBar on mobile devices
          appBar: isLargeScreen
              ? null
              : AppBar(
                  elevation: 1,
                  title: Text(
                    S.of(context).login,
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
          body: Center(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: formWidth,
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AuthHeader(show: !isLargeScreen),
                        SizedBox(height: context.height * .02),
                        // Title for wide screens (since there's no AppBar)
                        if (isLargeScreen) ...[
                          Text(
                            S.of(context).login,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: primaryGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24.0),
                        ],

                        // Email field
                        STextField(
                          controller: controller.emailController,
                          textHint: S.of(context).enterYourEmail,
                          labelText: S.of(context).email,
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).emailRequired;
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return S.of(context).invalidEmail;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // Password field
                        STextField(
                          controller: controller.passwordController,
                          textHint: S.of(context).enterYourPassword,
                          labelText: S.of(context).password,
                          icon: Icons.lock,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).passwordRequired;
                            }
                            return null;
                          },
                        ),

                        // Forgot Password option
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _navigateToForgotPassword,
                            child: Text(
                              S.of(context).forgotPassword,
                              style: TextStyle(
                                color: primaryGreen,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24.0),

                        // Login Button
                        ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            S.of(context).login,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Register option
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(S.of(context).dontHaveAnAccount),
                            const SizedBox(width: 4.0),
                            TextButton(
                              onPressed: _navigateToRegister,
                              child: Text(
                                S.of(context).register,
                                style: TextStyle(
                                  color: primaryGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
