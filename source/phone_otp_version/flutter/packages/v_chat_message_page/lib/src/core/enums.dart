// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

enum VMessageItemClickRes {
  forward,
  reply,
  share,
  info,
  delete,
  copy,
  download,
  star,
  unStar,
}

enum LoadMoreStatus { loading, loaded, error, completed }

enum CallStatus {
  //when init the stream
  connecting,
  busy,
  ring,
  //call started
  accepted,
  roomAlreadyInCall,
  timeout,
  //when any user close the chat
  callEnd,
  rejected,
}

extension CallStatusExt on CallStatus {
  bool get isConnecting => this == CallStatus.connecting;

  bool get busy => this == CallStatus.busy;

  bool get ring => this == CallStatus.ring;

  bool get accepted => this == CallStatus.accepted;

  bool get timeout => this == CallStatus.timeout;

  bool get callEnd => this == CallStatus.callEnd;

  bool get rejected => this == CallStatus.rejected;

  bool get roomAlreadyInCall => this == CallStatus.roomAlreadyInCall;
}