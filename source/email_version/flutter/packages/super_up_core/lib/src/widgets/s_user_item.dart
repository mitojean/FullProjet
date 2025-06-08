// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:v_platform/v_platform.dart';

import '../../super_up_core.dart';

class SUserItem extends StatelessWidget {
  final SBaseUser baseUser;
  final String? subtitle;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool hasBadge;

  const SUserItem({
    super.key,
    required this.baseUser,
    this.onLongPress,
    this.hasBadge = false,
    this.trailing,
    this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      onTap: onTap,
      subtitle: subtitle?.text,
      //onLongPress: onLongPress,
      title: baseUser.fullName.text,
      padding: EdgeInsets.zero,
      leadingSize: 50,
      leading: _getLeading(),
      additionalInfo: trailing ??
          Icon(
            context.isRtl
                ? CupertinoIcons.chevron_back
                : CupertinoIcons.chevron_forward,
          ),
    );
  }

  Widget _getLeading() {
    if (!hasBadge) {
      return VCircleAvatar(
        vFileSource: VPlatformFile.fromUrl(networkUrl: baseUser.userImage),
        radius: 50,
      );
    }
    return VCircleVerifiedAvatar(
      vFileSource: VPlatformFile.fromUrl(networkUrl: baseUser.userImage),
      radius: 50,
    );
  }
}
