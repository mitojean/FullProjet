// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

import '../../../../v_chat_message_page.dart';
import 'message_single_status_controller.dart';

class VMessageSingleStatusPage extends StatefulWidget {
  final VBaseMessage message;
  final VMessageLocalization vMessageLocalization;
  final String readLabel;
  final String deliveredLabel;

  const VMessageSingleStatusPage({
    super.key,
    required this.message,
    required this.readLabel,
    required this.deliveredLabel,
    required this.vMessageLocalization,
  });

  @override
  State<VMessageSingleStatusPage> createState() =>
      _VMessageSingleStatusPageState();
}

class _VMessageSingleStatusPageState extends State<VMessageSingleStatusPage>
    with StreamMix {
  late final MessageSingleStatusController controller;

  @override
  void initState() {
    controller = MessageSingleStatusController();
    streamsMix.addAll([
      VEventBusSingleton.vEventBus
          .on<VUpdateMessageDeliverEvent>()
          .where((e) => e.roomId == widget.message.roomId)
          .listen(_handleDeliver),
      VEventBusSingleton.vEventBus
          .on<VUpdateMessageSeenEvent>()
          .where((e) => e.roomId == widget.message.roomId)
          .listen(_handleSeen),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDark ? null : CupertinoColors.systemGrey6,
      appBar: AppBar(
        title: Text(
          widget.vMessageLocalization.info,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VMessageItem(
                  language: widget.vMessageLocalization,
                  roomType: VRoomType.s,
                  voiceController: controller.getVoiceController,
                  message: widget.message,
                  onSwipe: null,
                  onReSend: (message) {},
                  onHighlightMessage: (message) {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ChatSettingsTileInfo(
                padding: EdgeInsets.zero,
                title: Column(
                  children: [
                    ReadItem(
                      dateTime: widget.message.seenAtDate,
                      title: widget.readLabel,
                      model: MessageStatusIconDataModel(
                        isMeSender: widget.message.isMeSender,
                        emitStatus: widget.message.emitStatus,
                        isDeliver: false,
                        isSeen: true,
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    ReadItem(
                      title: widget.deliveredLabel,
                      dateTime: widget.message.deliveredAtDate,
                      model: MessageStatusIconDataModel(
                        isMeSender: widget.message.isMeSender,
                        emitStatus: widget.message.emitStatus,
                        isDeliver: true,
                        isSeen: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
    closeStreamMix();
  }

  void _handleDeliver(VUpdateMessageDeliverEvent event) {
    widget.message.deliveredAt = event.model.date;
    setState(() {});
  }

  void _handleSeen(VUpdateMessageSeenEvent event) {
    widget.message.seenAt = event.model.date;
    setState(() {});
  }
}

class ReadItem extends StatelessWidget {
  final DateTime? dateTime;
  final String title;
  final MessageStatusIconDataModel model;

  const ReadItem({
    super.key,
    this.dateTime,
    required this.title,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MessageStatusIcon(
                model: model,
              ),
              const SizedBox(
                width: 4,
              ),
              title.text.size(16),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          dateTime == null
              ? const SizedBox(
                  height: 10,
                )
              : format(
                  dateTime!,
                  locale: Localizations.localeOf(context).languageCode,
                ).text.color(Colors.green).size(14)
        ],
      ),
    );
  }
}
