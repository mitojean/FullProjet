// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:v_chat_room_page/src/room/pages/room_page/room_provider.dart';
import 'package:v_chat_room_page/src/room/shared/extentions.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';
import 'package:v_platform/v_platform.dart';

///  RoomStateController is a ValueNotifier which holds a VPaginationModel of VRoom objects. */ class RoomStateController extends ValueNotifier<VPaginationModel > {
///   RoomProvider instance that is used to fetch room data. */ final RoomProvider _roomProvider;
///  Flag that indicates whether all available data has been fetched from the server. */ bool isFinishLoadMore = false;
///  Flag that indicates whether a load more operation is currently in progress. */ bool _isLoadMoreActive = false; }
class RoomStateController extends ValueNotifier<VPaginationModel<VRoom>> {
  final RoomProvider _roomProvider;
  bool isFinishLoadMore = false;
  bool _isLoadMoreActive = false;

  RoomStateController(this._roomProvider)
      : super(
          VPaginationModel<VRoom>(
            data: <VRoom>[],
            limit: 20,
            page: 2,
            nextPage: null,
          ),
        );

  final roomStateStream = StreamController<VRoom>.broadcast(sync: true);

  List<VRoom> get stateRooms => value.data;

  void updateCacheStateForChatRooms(VPaginationModel<VRoom> paginationModel) {
    final Map<String, VRoom> stateRoomMap =
        Map.fromEntries(value.data.map((vRoom) => MapEntry(vRoom.id, vRoom)));
    final apiRooms = paginationModel.data;

    for (var apiRoom in apiRooms) {
      if (stateRoomMap.containsKey(apiRoom.id)) {
        final stateLastMessage = stateRoomMap[apiRoom.id]!.lastMessage;
        if (stateLastMessage.contentTr != null) {
          apiRoom.lastMessage.contentTr = stateLastMessage.contentTr;
        }
        // Api room exists in local rooms. Check if local room contains sending message
        if (stateLastMessage.emitStatus.isSendingOrError) {
          stateRoomMap[apiRoom.id] = apiRoom;
          stateRoomMap[apiRoom.id]!.lastMessage = stateLastMessage;
        } else {
          stateRoomMap[apiRoom.id] = apiRoom;
        }
      } else {
        // If room does not exist, add it to the start of the list
        stateRoomMap[apiRoom.id] = apiRoom;
      }
    }

    // We need to sort the list by msg id
    final newStateRoomsList = stateRoomMap.values.toList();
    newStateRoomsList.sortByMsgId();

    value.data = newStateRoomsList;
    notifyListeners();
  }

  void insertRoom(VRoom room) {
    if (!stateRooms.contains(room)) {
      value.data.insert(0, room);
    } else {
      if (room.isDeleted) {
        room.isDeleted = false;
      }
      if (kDebugMode) {
        print(
            "-------------you are try to insert message which already exist!-----------");
      }
    }
    notifyListeners();
  }

  void close() {
    dispose();
    roomStateStream.close();
  }

  VRoom? roomById(String roomId) =>
      stateRooms.firstWhereOrNull((e) => e.id == roomId);

  void updateOnline(String roomId) {
    final room = roomById(roomId);
    if (room != null) {
      room.isOnline = true;
      roomStateStream.sink.add(room);
    }
  }

  void updateOffline(String roomId) {
    final room = roomById(roomId);
    if (room != null) {
      room.isOnline = false;
      roomStateStream.sink.add(room);
    }
  }

  void updateTyping(String roomId, VSocketRoomTypingModel typingModel) {
    final room = roomById(roomId);
    if (room != null) {
      room.typingStatus = typingModel;
      roomStateStream.sink.add(room);
    }
  }

  void updateTitle(String roomId, String title) {
    final room = roomById(roomId);
    if (room != null) {
      room.title = title;
      roomStateStream.sink.add(room);
    }
  }

  void updateImage(String roomId, String image) {
    final room = roomById(roomId);
    if (room != null) {
      room.thumbImage = image;
      roomStateStream.sink.add(room);
    }
  }

  void updateCounterByOne(String roomId) {
    final room = roomById(roomId);
    if (room != null) {
      if (!VPlatforms.isWeb) {
        ///because in web i use in memory database so it already updated
        room.unReadCount = ++room.unReadCount;
      }
      roomStateStream.sink.add(room);
    }
  }

  void updateNickName(VUpdateLocalRoomNickNameEvent event) {
    final room = roomById(event.roomId);
    if (room != null) {
      room.nickName = event.name;
      roomStateStream.sink.add(room);
    }
  }

  void resetRoomCounter(String roomId) {
    final room = roomById(roomId);
    if (room != null) {
      room.unReadCount = 0;
      roomStateStream.sink.add(room);
    }
  }

  void updateMute(String roomId, bool isMuted) {
    final room = roomById(roomId);
    if (room != null) {
      room.isMuted = isMuted;
      roomStateStream.sink.add(room);
    }
  }

  void deleteRoom(String roomId) {
    final room = roomById(roomId);
    if (room != null) {
      room.isDeleted = true;
      roomStateStream.sink.add(room);
    }
    notifyListeners();
  }

  void deleteRoomLastMessage(VDeleteMessageEvent event) {
    final room = roomById(event.roomId);
    if (room != null && room.lastMessage.localId == event.localId) {
      if (event.upMessage != null) {
        room.lastMessage = event.upMessage!;
      } else {
        room.lastMessage.isDeleted = true;
      }
      roomStateStream.sink.add(room);
    }
  }

  void deliverRoomLastMessage(VUpdateMessageDeliverEvent event) {
    final room = roomById(event.roomId);
    if (room != null) {
      room.lastMessage.deliveredAt = event.model.date;
      roomStateStream.sink.add(room);
    }
  }

  void seenRoomLastMessage(VUpdateMessageSeenEvent event) {
    final room = roomById(event.roomId);
    if (room != null) {
      room.lastMessage.seenAt = event.model.date;
      room.lastMessage.deliveredAt ??= event.model.date;
      room.mentionsCount = 0;
      roomStateStream.sink.add(room);
    }
  }

  void updateRoomLastMessageAllDelete(VUpdateMessageAllDeletedEvent event) {
    final room = roomById(event.roomId);
    if (room != null && room.lastMessage.localId == event.localId) {
      room.lastMessage.allDeletedAt = event.message.allDeletedAt;
      roomStateStream.sink.add(room);
    }
  }

  void updateRoomLastMessageStatus(VUpdateMessageStatusEvent event) {
    final room = roomById(event.roomId);
    if (room != null && room.lastMessage.localId == event.localId) {
      room.lastMessage.emitStatus = event.emitState;
      roomStateStream.sink.add(room);
    }
  }

  void updateRoomLastMessage(VUpdateMessageEvent event) {
    final room = roomById(event.roomId);
    if (room != null && room.lastMessage.localId == event.localId) {
      room.lastMessage = event.messageModel;
      roomStateStream.sink.add(room);
    }
  }

  void insertRoomLastMessage(VInsertMessageEvent event) async {
    final room = roomById(event.roomId);
    if (room != null) {
      room.isDeleted = false;
      room.lastMessage = event.messageModel;
      stateRooms.sortByMsgId();
      notifyListeners();
    } else {
      final localRoom = await _roomProvider.getLocalRoomById(event.roomId);
      if (localRoom != null) {
        insertRoom(localRoom);
      }
    }
  }

  void insertAll(VPaginationModel<VRoom> response) {
    value.data = response.data;
    notifyListeners();
  }

  Future<bool> onLoadMore() async {
    if (_isLoadMoreActive) {
      return false;
    }
    final res = await vSafeApiCall<VPaginationModel<VRoom>>(
      onLoading: () {
        _isLoadMoreActive = true;
      },
      request: () async {
        return _roomProvider.getApiRooms(
          VRoomsDto(page: value.page, limit: 20),
          deleteOnEmpty: false,
        );
      },
      onSuccess: (response) {
        ++value.page;
        if (response.data.isEmpty) {
          isFinishLoadMore = true;
        }
        for (final e in response.data) {
          if (!value.data.contains(e)) {
            value.data.add(e);
          }
        }
        value.data.sortByMsgId();
        notifyListeners();
        _isLoadMoreActive = false;
      },
      onError: (exception, trace) {
        if (kDebugMode) {
          print(exception);
        }
        if (kDebugMode) {
          print(trace);
        }
        _isLoadMoreActive = false;
      },
    );
    if (res == null || res.data.isEmpty) {
      return false;
    }
    return true;
  }

  void sortRoomsByUnreadCount() {
    value.data = value.data.where((e) => e.unReadCount != 0).toList();
    notifyListeners();
  }

  void sortRoomsBy(VRoomType type) {
    switch (type) {
      case VRoomType.s:
        value.data = value.data.where((e) => e.roomType.isSingle).toList();
        notifyListeners();
        break;
      case VRoomType.g:
        value.data = value.data.where((e) => e.roomType.isGroup).toList();
        notifyListeners();
        break;
      case VRoomType.b:
        value.data = value.data.where((e) => e.roomType.isBroadcast).toList();
        notifyListeners();
        break;
      case VRoomType.o:
        value.data = value.data.where((e) => e.roomType.isOrder).toList();
        notifyListeners();
        break;
    }
  }

  void setRoomSelected(String roomId) {
    //first un select
    for (int i = 0; i < value.data.length; i++) {
      if (value.data[i].isSelected) {
        value.data[i].isSelected = false;
        roomStateStream.sink.add(value.data[i]);
      }
    }
    final room = roomById(roomId);
    if (room != null) {
      room.isSelected = true;
      roomStateStream.sink.add(room);
    }
  }

  void updateRoomMention(VUpdateRoomMemberMention event) {
    final room = roomById(event.roomId);
    if (room != null) {
      room.mentionsCount = event.count;
      roomStateStream.sink.add(room);
    }
  }

  void updateOneSeen(VUpdateRoomOneSeenEvent event) {
    final room = roomById(event.roomId);
    if (room != null) {
      room.isOneSeen = event.isEnable;
      roomStateStream.sink.add(room);
    }
  }
}
