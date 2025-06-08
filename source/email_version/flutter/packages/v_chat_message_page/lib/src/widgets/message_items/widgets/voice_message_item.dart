// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:v_chat_message_page/v_chat_message_page.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

class VoiceMessageItem extends StatelessWidget {
  final VVoiceMessage message;
  final VVoiceMessageController? Function(VBaseMessage message) voiceController;

  const VoiceMessageItem({
    super.key,
    required this.message,
    required this.voiceController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300,
      ),
      padding: const EdgeInsets.all(10),
      child: Material(
        color: Colors.transparent,
        child: VVoiceMessageView(
          backgroundColor: context.isDark
              ? Colors.grey.withValues(alpha: .4)
              : Colors.grey.withValues(alpha: .4),
          controller: voiceController(message)!,
          notActiveSliderColor: context
              .getMessageItemHolderColor(
                message.isMeSender,
                context,
              )
              .withValues(alpha: 1),
          activeSliderColor:
              context.isDark ? CupertinoColors.systemGreen : Colors.red,
        ),
      ),
    );
  }
}
