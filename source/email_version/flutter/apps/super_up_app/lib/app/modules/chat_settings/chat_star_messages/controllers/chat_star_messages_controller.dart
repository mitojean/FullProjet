// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:v_chat_message_page/v_chat_message_page.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

class ChatStarMessagesController
    extends SLoadingController<List<VBaseMessage>> {
  final txtController = TextEditingController();
  final String? roomId;
  final scrollController = ScrollController();

  ChatStarMessagesController(
    this.roomId,
  ) : super(SLoadingState([]));
  late final VVoicePlayerController voiceControllers;

  @override
  void onClose() {
    super.dispose();
    txtController.dispose();
    voiceControllers.close();
  }

  @override
  void onInit() {
    getData();
    _setUpVoiceController();
  }

  void _setUpVoiceController() {
    voiceControllers = VVoicePlayerController(
      (localId) {
        final index = value.data.indexWhere((e) => e.localId == localId);
        if (index == -1 || index == 0) {
          return null;
        }
        if (!value.data[index - 1].messageType.isVoice) {
          return null;
        }
        return value.data[index - 1].localId;
      },
    );
  }

  Future<void> getData() async {
    await vSafeApiCall<List<VBaseMessage>>(
      onLoading: () async {
        setStateLoading();
        update();
      },
      onError: (exception, trace) {
        setStateError();
        update();
      },
      request: () async {
        if (roomId == null) {
          return VChatController.I.nativeApi.remote.room.getAllStarMessages();
        }
        return VChatController.I.nativeApi.remote.message
            .getStarRoomMessages(roomId: roomId!);
      },
      onSuccess: (response) {
        value.data = response;
        if (value.data.isEmpty) {
          setStateEmpty();
        } else {
          setStateSuccess();
        }
      },
      ignoreTimeoutAndNoInternet: false,
    );
  }

  Future onLongTab(BuildContext context, VBaseMessage message) async {
    final res = await VAppAlert.showModalSheetWithActions<int>(
      content: [ModelSheetItem<int>(title: S.of(context).unStar, id: 1)],
      context: context,
    );
    if (res == null) return;
    if (res.id == 1) {
      vSafeApiCall(
        request: () async {
          await VChatController.I.nativeApi.remote.message
              .unStarMessage(message.roomId, message.id);
        },
        onSuccess: (response) {
          getData();
        },
      );
    }
  }
}
