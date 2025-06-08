// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

import '../../../peer_profile/states/peer_profile_state.dart';

class SingleRoomSettingState {
    VToChatSettingsModel settingsModel;
  PeerProfileModel? user;
  bool isUpdatingMute = false;
  bool isUpdatingOneSeen = false;
  bool isUpdatingBlock = false;

  SingleRoomSettingState(this.settingsModel);
}
