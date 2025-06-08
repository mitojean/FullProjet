// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up_core/super_up_core.dart';
import '../../widgets/auth_header.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final ForgetPasswordController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = ForgetPasswordController();
    controller.onInit();
  }

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  // Handle sending email for password reset
  void _handleSendEmail() {
    if (_formKey.currentState!.validate()) {
      controller.sendEmail(context);
    }
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
          appBar: AppBar(
            elevation: 1,
            title: Text(
              S.of(context).forgetPassword,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
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

                        // Title for wide screens (if the AppBar is hidden)
                        if (isLargeScreen) ...[
                          Text(
                            S.of(context).forgetPassword,
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
                          autofocus: true,
                          controller: controller.emailController,
                          textHint: S.of(context).enterYourEmail,
                          labelText: S.of(context).email,
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          autocorrect: false,
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

                        const SizedBox(height: 40),

                        // Send Code Button
                        ElevatedButton(
                          onPressed: _handleSendEmail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            S.of(context).sendCodeToMyEmail,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Back to Login option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(S.of(context).alreadyHaveAnAccount),
                            const SizedBox(width: 4.0),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
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
