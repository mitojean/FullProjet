import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up/app/core/app_nav/app_navigation.dart';
import 'package:super_up/app/modules/auth/continue_get_data/continue_get_data_screen.dart';
import 'package:super_up/app/modules/auth/phone_login/otp_screen.dart';
import 'package:super_up/main.dart';
import 'package:super_up_core/super_up_core.dart';

class SocialUser {
  String authId;
  String? identifier;
  String? email;
  String? name;
  String? photo;
  RegisterMethod type;

//<editor-fold desc="Data Methods">
  SocialUser({
    required this.authId,
    this.email,
    this.identifier,
    this.name,
    this.photo,
    required this.type,
  });

  @override
  String toString() {
    return 'SocialUser{ identifier: $authId, email: $email, name: $name, photo: $photo, type: $type,}';
  }

  Map<String, dynamic> toMap() {
    return {
      'identifier': authId,
      'email': email,
      'name': name,
      'identifier': identifier,
      'photo': photo,
      'type': type.name,
    };
  }

//</editor-fold>
}

class SocialLoginAuth {
  // static final _googleSignIn = GoogleSignIn();
  static final auth = FirebaseAuth.instance;


  static Future<void> emailSignIn({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> emailCreateAccount({
    required String email,
    required String password,
  }) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }



  static Future<SocialUser?> phoneSignIn(String phoneNumber) async {
    final context = navigatorKey.currentState!.context;
    VAppAlert.showLoading(context: context);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification completed (mainly on Android)
          context.pop(); // Dismiss loading
          try {
            await FirebaseAuth.instance.signInWithCredential(credential);
            AppNavigation.toPage(
              context,
              ContinueGetDataScreen(
                socialUser: SocialUser(
                  authId: phoneNumber,
                  type: RegisterMethod.phone,
                ),
              ),
            );
          } catch (e) {
            _handleFirebaseAuthError(context, e);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          context.pop(); // Dismiss loading
          _handleFirebaseAuthError(context, e);
        },
        codeSent: (String verificationId, int? resendToken) {
          context.pop(); // Dismiss loading
          AppNavigation.toPage(
            context,
            OTPScreen(
              verificationId: verificationId,
              userPhone: phoneNumber,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Only handle if loading is still shown (no code sent yet)
          if (ModalRoute.of(context)?.isCurrent != true) return;

          context.pop(); // Dismiss loading if still showing
          VAppAlert.showOkAlertDialog(
            context: context,
            title: S.of(context).error,
            //todo trans
            content: "Verification code request timed out. Please try again.",
          );
        },
      );

      return SocialUser(
        authId: phoneNumber,
        type: RegisterMethod.phone,
      );
    } catch (e) {
      context.pop(); // Ensure loading is dismissed
      _handleFirebaseAuthError(context, e);
      return null;
    }
  }

// Helper method to handle Firebase Auth errors with localized messages
  static void _handleFirebaseAuthError(BuildContext context, dynamic error) {
    String errorMessage;

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-phone-number':
          errorMessage =
              "The phone number format is incorrect. Please enter a valid number.";
          break;
        case 'too-many-requests':
          errorMessage =
              "We've received too many requests from this device. Try again later.";
          break;
        case 'quota-exceeded':
          errorMessage = "The SMS quota for the project has been exceeded.";
          break;
        case 'user-disabled':
          errorMessage =
              "This account has been disabled. Please contact support.";
          break;
        case 'app-not-authorized':
          errorMessage =
              "This app is not authorized to use Firebase Authentication.";
          break;
        case 'captcha-check-failed':
          errorMessage = "The reCAPTCHA verification failed. Please try again.";
          break;
        case 'missing-phone-number':
          errorMessage = "Please provide a phone number.";
          break;
        case 'session-expired':
          errorMessage =
              "The verification session has expired. Please try again.";
          break;
        case 'network-request-failed':
          errorMessage =
              "A network error occurred. Please check your connection and try again.";
          break;
        default:
          errorMessage = "Verification failed: ${error.message ?? error.code}";
          break;
      }
    } else if (error is TimeoutException) {
      //todo trans
      errorMessage = "Verification timed out. Please try again.";
    } else {
      //todo trans
      errorMessage = "An unknown error occurred. Please try again.";
      if (kDebugMode) {
        print("Firebase Phone Auth Error: $error");
      }
    }

    // Show error dialog
    VAppAlert.showOkAlertDialog(
      context: context,
      title: S.of(context).error,
      content: errorMessage,
    );
  }
}
