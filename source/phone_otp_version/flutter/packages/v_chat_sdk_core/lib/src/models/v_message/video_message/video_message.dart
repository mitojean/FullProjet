// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:v_chat_sdk_core/src/local_db/tables/message_table.dart';
import 'package:v_chat_sdk_core/src/utils/v_message_constants.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';
import 'package:v_platform/v_platform.dart';

class VVideoMessage extends VBaseMessage
    implements VDownloadableMessage, VUploadMessage {
  final VMessageVideoData data;

  VVideoMessage({
    required super.id,
    required super.senderId,
    required super.linkAtt,
    required super.emitStatus,
    required super.senderName,
    required super.contentTr,
    required super.isEncrypted,
    required super.senderImageThumb,
    required super.platform,
    required super.roomId,
    required super.content,
    required super.messageType,
    required super.localId,
    required super.createdAt,
    required super.updatedAt,
    required super.replyTo,
    required super.seenAt,
    required super.deliveredAt,
    required super.forwardId,
    required super.allDeletedAt,
    required super.parentBroadcastId,
    required super.isStared,
    required this.data,
  });

  VVideoMessage.fromRemoteMap(super.map)
      : data = VMessageVideoData.fromMap(
          map['msgAtt'] as Map<String, dynamic>,
        ),
        super.fromRemoteMap();

  VVideoMessage.fromLocalMap(super.map)
      : data = VMessageVideoData.fromMap(
          jsonDecode(map[MessageTable.columnAttachment] as String)
              as Map<String, dynamic>,
        ),
        super.fromLocalMap();

  VVideoMessage.buildMessage({
    required super.roomId,
    required this.data,
    super.forwardId,
    super.broadcastId,
    super.replyTo,
  }) : super.buildMessage(
          linkAtt: null,
          isEncrypted: false,
          messageType: VMessageType.video,
          content: VMessageConstants.thisContentIsVideo,
        );

  @override
  List<PartValue> toListOfPartValue() {
    return [
      ...super.toListOfPartValue(),
      PartValue(
        'attachment',
        jsonEncode(data.toMap()),
      ),
    ];
  }

  @override
  Map<String, dynamic> toLocalMap({
    bool withOutConTr = false,
    bool withOutIsDownload = false,
  }) {
    return {
      ...super.toLocalMap(),
      MessageTable.columnAttachment: jsonEncode(data.toMap()),
    };
  }

  @override
  VPlatformFile get fileSource => data.fileSource;

  @override
  bool get isFileDownloaded => VFileUtils.isFileExists(localFilePathWithExt);

  @override
  String get localFilePathWithExt => fileSource.fileHash + fileSource.extension;
}
