// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:super_up_core/src/v_chat/v_update/theme/v_theme_listener.dart';

import 'language/v_language_listener.dart';

class VUtilsWrapper extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    Locale locale,
    ThemeMode themeMode,
  ) builder;

  const VUtilsWrapper({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: VLanguageListener.I,
      builder: (context, values, _) => ValueListenableBuilder(
        valueListenable: VThemeListener.I,
        builder: (context, values, _) {
          return builder(
            context,
            VLanguageListener.I.appLocal,
            VThemeListener.I.appTheme,
          );
        },
      ),
    );
  }
}
