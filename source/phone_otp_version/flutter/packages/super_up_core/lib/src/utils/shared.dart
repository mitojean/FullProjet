// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../super_up_core.dart';

BoxDecoration sMessageBackground({
  required bool isDark,
}) {
  if (isDark) {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/message/pattern_dark.png"),
        repeat: ImageRepeat.repeat,
        colorFilter: ColorFilter.mode(
          Colors.black,
          BlendMode.color,
        ),
      ),
    );
  }
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/message/pattern_light.png"),
      repeat: ImageRepeat.repeat,
      colorFilter: ColorFilter.mode(
        Colors.transparent,
        BlendMode.color,
      ),
    ),
  );
}

abstract class AppAuth {
  static SMyProfile? _profile;

  static void setProfileNull() {
    _profile = null;
  }

  static bool get isPhoneLogin => myProfile.authMethod.type == RegisterMethod.phone;
  static bool get isLoginByEmail => myProfile.authMethod.type == RegisterMethod.email;

  static SMyProfile get myProfile {
    if (_profile != null) {
      return _profile!;
    }
    final map = VAppPref.getMap(SStorageKeys.myProfile.name);
    if (map == null) throw 'user is not logged in';
    final x = SMyProfile.fromMap(map);
    _profile = x;
    return _profile!;
  }

  static String get myId => myProfile.baseUser.id;
}
