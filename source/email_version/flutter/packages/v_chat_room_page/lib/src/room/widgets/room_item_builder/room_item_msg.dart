// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:textless/textless.dart';
import 'package:v_chat_room_page/src/room/shared/shared.dart';
import 'package:v_chat_room_page/src/room/shared/v_message_constants.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

/// A widget that displays a message in a chat room item. /// /// The [message] parameter is the message to be displayed. /// The [isBold] parameter determines if the message should be displayed in bold text. class RoomItemMsg extends StatelessWidget { final bool isBold; final VBaseMessage message;
/// A widget that displays a message in a chat room item. /// /// The [message] parameter is the message to be displayed. /// The [isBold] parameter determines if the message should be displayed in bold text. class RoomItemMsg extends StatelessWidget { final bool isBold; final VBaseMessage message;const RoomItemMsg({ Key? key, required this.message, required this.isBold, }) : super(key: key); }
class RoomItemMsg extends StatelessWidget {
  /// The message to be displayed.
  final bool isBold;
  final String messageHasBeenDeletedLabel;

  /// Determines if the message should be displayed in bold text.
  final VBaseMessage message;

  /// Creates a [RoomItemMsg] widget.
  const RoomItemMsg({
    super.key,
    required this.message,
    required this.isBold,
    required this.messageHasBeenDeletedLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.vRoomTheme;
    final language = VMessageInfoTrans(
      addedYouToNewBroadcast: S.of(context).addedYouToNewBroadcast,
      dismissedToMemberBy: S.of(context).dismissedToMemberBy,
      groupCreatedBy: S.of(context).groupCreatedBy,
      joinedBy: S.of(context).joinedBy,
      kickedBy: S.of(context).kickedBy,
      leftTheGroup: S.of(context).leftTheGroup,
      promotedToAdminBy: S.of(context).promotedToAdminBy,
      updateImage: S.of(context).updateImage,
      updateTitleTo: S.of(context).updateTitleTo,
      you: S.of(context).you,
    );

    if (message.allDeletedAt != null) {
      return messageHasBeenDeletedLabel.text.italic.color(Colors.grey);
    }
    if (message.isDeleted) {
      return VMessageConstants.getMessageBody(message, language)
          .text
          .lineThrough;
    }
    if (message.isOneSeen) {
      return Row(
        children: [
          S.of(context).oneSeenMessage.text.black.italic.color(Colors.red),
        ],
      );
    }
    if (isBold) {
      return VTextParserWidget(
        text: VMessageConstants.getMessageBody(message, language),
        enableTabs: false,
        isOneLine: true,
        textStyle: theme.unSeenLastMessageTextStyle,
      );
    }

    return VTextParserWidget(
      text: VMessageConstants.getMessageBody(message, language),
      enableTabs: false,
      isOneLine: true,
      textStyle: theme.seenLastMessageTextStyle,
    );
  }
}
