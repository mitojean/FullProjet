// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:v_chat_sdk_core/src/models/models.dart';

class VToChatSettingsModel {
  String title;
  String image;
  String roomId;
  VRoom room;

  VToChatSettingsModel({
    required this.title,
    required this.image,
    required this.roomId,
    required this.room,
  });

  @override
  String toString() {
    return 'VToChatSettingsModel{title: $title, image: $image, roomId: $roomId room $room}';
  }

  VToChatSettingsModel copyWith({
    String? title,
    String? image,
    String? roomId,
    VRoom? room,
  }) {
    return VToChatSettingsModel(
      title: title ?? this.title,
      image: image ?? this.image,
      roomId: roomId ?? this.roomId,
      room: room ?? this.room,
    );
  }
}
