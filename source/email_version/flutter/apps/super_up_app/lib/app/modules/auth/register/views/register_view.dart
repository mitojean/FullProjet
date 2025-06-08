import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up/app/modules/auth/login/views/login_view.dart';
import 'package:super_up_core/super_up_core.dart';

import '../../../../core/api_service/auth/auth_api_service.dart';
import '../../../../core/api_service/profile/profile_api_service.dart';
import '../../widgets/auth_header.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  late final RegisterController controller;

  // Visibility toggle for password fields
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    controller = RegisterController(
      GetIt.I.get<AuthApiService>(),
      GetIt.I.get<ProfileApiService>(),
    );
    controller.onInit();
  }

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  // Handle register button press
  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      controller.register(context);
    }
  }

  void _navigateToLogin() {
    context.toPage(LoginView());
  }

  @override
  Widget build(BuildContext context) {
    // Define green theme color
    const Color primaryGreen = Color(0xFF4CAF50);

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
                    S.of(context).register,
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                  // Add language and theme options to AppBar on small screens
                  actions: [
                    // Language selector
                    IconButton(
                      icon: Icon(
                        Icons.language,
                        color: context.isDark ? Colors.white : Colors.black,
                      ),
                      tooltip: 'Change Language',
                      onPressed:()=> controller.changeLang(context),
                    ),
                    // Theme toggle
                    IconButton(
                      icon: const Icon(Icons.brightness_6),
                      tooltip: 'Toggle Theme',
                      color: context.isDark ? Colors.white : Colors.black,
                      onPressed:()=> controller.changeTheme(context),
                    ),
                  ],
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
                        // Title for wide screens with language and theme options
                        if (isLargeScreen) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  S.of(context).register,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: primaryGreen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Language selector for large screens
                              IconButton(
                                icon: const Icon(Icons.language),
                                tooltip: 'Change Language',
                                onPressed:()=> controller.changeLang(context),
                              ),
                              // Theme toggle for large screens
                              IconButton(
                                icon: const Icon(Icons.brightness_6),
                                tooltip: 'Toggle Theme',
                                onPressed:()=> controller.changeTheme(context),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                        ],

                        // Name field
                        STextField(
                          controller: controller.nameController,
                          textHint: S.of(context).enterYourName,
                          labelText: S.of(context).fullName,
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).nameRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),

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
                            if (value.length < 8) {
                              return S.of(context).passwordTooShort;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // Confirm password field
                        STextField(
                          controller: controller.confirmController,
                          textHint: S.of(context).confirmYourPassword,
                          labelText: S.of(context).confirmPassword,
                          icon: Icons.lock_outline,
                          obscureText: _obscureConfirmPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).confirmPasswordRequired;
                            }
                            if (value != controller.passwordController.text) {
                              return S.of(context).passwordsDontMatch;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),

                        // Register Button
                        ElevatedButton(
                          onPressed: _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            S.of(context).register,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Login option
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(S.of(context).alreadyHaveAnAccount),
                            const SizedBox(width: 4.0),
                            TextButton(
                              onPressed: _navigateToLogin,
                              child: Text(
                                S.of(context).login,
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
