// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up_core/super_up_core.dart';
import '../../widgets/auth_header.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;

  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final ResetPasswordController controller;
  final _formKey = GlobalKey<FormState>();

  // Define green theme color
  static const Color primaryGreen = Color(0xFF4CAF50);

  @override
  void initState() {
    super.initState();
    controller = ResetPasswordController(widget.email);
    controller.onInit();
  }

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  // Handle reset password button press
  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      controller.resetPassword(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pinput themes
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: primaryGreen, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.grey.shade100,
        border: Border.all(color: primaryGreen),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if we're on a large screen
        final isLargeScreen = constraints.maxWidth > 600;

        // Calculate the form width based on screen size
        final formWidth = isLargeScreen ? 500.0 : constraints.maxWidth * 0.9;

        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text(
              S.of(context).resetPassword,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SafeArea(
            bottom: false,
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
                        // Auth header component
                        AuthHeader(show: !isLargeScreen),

                        SizedBox(height: context.height * .02),

                        // Subtitle explaining what to do
                        Text(
                          S.of(context).enterTheCodeAndNewPassword,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        // PIN Input Field
                        Align(
                          alignment: Alignment.center,
                          child: Pinput(
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            length: 6,
                            submittedPinTheme: submittedPinTheme,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            controller: controller.codeController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return S.of(context).pleaseEnterValidCode;
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // New Password field
                        STextField(
                          controller: controller.newPasswordController,
                          textHint: S.of(context).enterNewPassword,
                          labelText: S.of(context).newPassword,
                          icon: Icons.lock_outline,
                          obscureText: true,
                          inputType: TextInputType.text,
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

                        const SizedBox(height: 16),

                        // Confirm Password field
                        STextField(
                          controller: controller.confirmPasswordController,
                          textHint: S.of(context).reenterNewPassword,
                          labelText: S.of(context).confirmPassword,
                          icon: Icons.lock_outline,
                          obscureText: true,
                          inputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).confirmPasswordRequired;
                            }
                            if (value !=
                                controller.newPasswordController.text) {
                              return S.of(context).passwordsDontMatch;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 40),

                        // Reset Password Button
                        ElevatedButton(
                          onPressed: _handleResetPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            S.of(context).resetPassword,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Resend code option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(S.of(context).didntReceiveCode),
                            const SizedBox(width: 4.0),
                            TextButton(
                              onPressed: () {
                                // TODO: Implement resend code functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(S.of(context).codeSentAgain),
                                  ),
                                );
                              },
                              child: Text(
                                S.of(context).resend,
                                style: TextStyle(
                                  color: primaryGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
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
