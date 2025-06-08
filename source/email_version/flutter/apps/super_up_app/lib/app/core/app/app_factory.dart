// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up/app/core/theme/app_theme_manager.dart';
import 'package:super_up/app/core/widgets/main_builder.dart';
import 'package:super_up/app/modules/splash/views/splash_view.dart';
import 'package:super_up_core/super_up_core.dart';

/// Factory class for creating the application widget
class AppFactory {
  /// Creates the main application widget
  static Widget createApp(GlobalKey<NavigatorState> navigatorKey) {
    return VUtilsWrapper(
      builder: (_, local, theme) {
        return OKToast(
          position: ToastPosition.bottom,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            title: SConstants.appName,
            locale: local,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) => MainBuilder(
              themeMode: theme,
              child: child,
            ),
            home: const SplashView(),
            debugShowCheckedModeBanner: false,
            theme: AppThemeManager.getLightTheme(),
            darkTheme: AppThemeManager.getDarkTheme(),
            themeMode:
                theme == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light,
          ),
        );
      },
    );
  }
}
