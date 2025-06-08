// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

class CallMessageItem extends StatelessWidget {
  final VCallMessage message;
  final String audioCallLabel;
  final String callStatusLabel;

  const CallMessageItem({
    super.key,
    required this.message,
    required this.audioCallLabel,
    required this.callStatusLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.all(5),
      child: CupertinoListTile(
        onTap: () {
          if (message.data.callStatus == VMessageCallStatus.ring) {
            VChatController.I.vNavigator.callNavigator.toCall(
              context,
              VCallDto(
                isVideoEnable: message.data.withVideo,
                roomId: message.roomId,
                peerUser: SBaseUser(
                  id: message.roomId,
                  fullName: S.of(context).group,
                  userImage: "default_group_image.png",
                ),
                isCaller: message.isMeSender,
              ),

            );
          }
        },
        title: "${message.senderName}       ".text.size(16),
        subtitle: Row(
          children: [
            _getSub(context),
            if (message.data.callStatus == VMessageCallStatus.ring)
              const SizedBox(
                width: 5,
              ),
            S.of(context).clickToJoin.cap
          ],
        ),
        leading: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: Icon(
            message.data.withVideo
                ? PhosphorIcons.videoCamera(PhosphorIconsStyle.fill)
                : PhosphorIcons.phoneCall(),
            color: Colors.white,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }

  Widget _getSub(BuildContext context) {
    if (message.data.duration != null) {
      return "${message.data.duration.toString()} S"
          .text
          .maxLine(2)
          .overflowEllipsis;
    }
    return callStatusLabel.toString().text.maxLine(2).overflowEllipsis;
  }
}
