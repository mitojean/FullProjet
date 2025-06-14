// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:textless/textless.dart';

/// A widget that represents the un-read count of chats. /// /// This widget can be used to display the number of un-read chats, typically /// used in a messaging app. The [unReadCount] property is required to set the /// number of un-read chats to be displayed. /// /// Example usage: /// /// dart /// ChatUnReadWidget(unReadCount: 3) /// class ChatUnReadWidget extends StatelessWidget {
/// The number of un-read chats to be displayed. final int unReadCount;
/// Creates a new instance of [ChatUnReadWidget]. /// /// The [unReadCount] property is required to set the number of un-read /// chats to be displayed. const ChatUnReadWidget({Key? key, required this.unReadCount}) : super(key: key); }
class ChatUnReadWidget extends StatelessWidget {
  /// The number of un-read chats to be displayed.
  final int unReadCount;

  /// Creates a new instance of [ChatUnReadWidget]. /// /// The [unReadCount] property is required to set the number of un-read /// chats to be displayed.
  const ChatUnReadWidget({super.key, required this.unReadCount});

  @override
  Widget build(BuildContext context) {
    if (unReadCount == 0) return const SizedBox.shrink();
    return FittedBox(
      child: Container(
        height: 20,
        padding: EdgeInsets.zero,
        width: 20,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: CupertinoColors.systemGreen, shape: BoxShape.circle),
        child: unReadCount.toString().text.size(15).color(Colors.red),
      ),
    );
  }
}
