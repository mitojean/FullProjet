// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:super_up_core/super_up_core.dart';
import 'package:v_chat_sdk_core/src/http/api_service/channel/channel_api.dart';
import 'package:v_chat_sdk_core/src/http/api_service/interceptors.dart';
import 'package:v_chat_sdk_core/src/models/v_mention_model.dart';
import 'package:v_chat_sdk_core/src/utils/api_constants.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';
import 'package:v_platform/v_platform.dart';

class VChannelApiService {
  static ChannelApi? _channelApiService;

  VChannelApiService._();

  Future<VRoom> getPeerRoom(String peerId) async {
    final res = await _channelApiService!.getPeerRoom(peerId);
    throwIfNotSuccess(res);
    return VRoom.fromMap(extractDataFromResponse(res));
  }

  Future<List<VBaseMessage>> getAllStarMessages() async {
    final res = await _channelApiService!.getAllStarMessages();
    throwIfNotSuccess(res);
    final data = extractDataFromResponse(res);
    final docs = data['docs'] as List;
    return docs
        .map(
          (e) => MessageFactory.createBaseMessage(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<bool> updateRoomNickName(String roomId, String text) async {
    final res = await _channelApiService!.updateRoomNickName(
      roomId,
      {"name": text},
    );
    throwIfNotSuccess(res);
    return true;
  }

  Future<VRoom> getRoomById(String roomId) async {
    final res = await _channelApiService!.getRoomById(roomId);
    throwIfNotSuccess(res);
    return VRoom.fromMap(extractDataFromResponse(res));
  }

  Future<bool> muteRoomNotification({required String roomId}) async {
    final res = await _channelApiService!.muteRoomNotification(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> unMuteRoomNotification({required String roomId}) async {
    final res = await _channelApiService!.unMuteRoomNotification(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> oneSeenOff({required String roomId}) async {
    final res = await _channelApiService!.oneSeenOff(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> oneSeenOn({required String roomId}) async {
    final res = await _channelApiService!.oneSeenOn(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> archiveRoom({required String roomId}) async {
    final res = await _channelApiService!.archiveRoom(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> unArchiveRoom({required String roomId}) async {
    final res = await _channelApiService!.unArchiveRoom(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<VMyOrderInfo> getOrderRoomInfo({required String roomId}) async {
    final res = await _channelApiService!.getOrderRoomInfo(roomId);
    throwIfNotSuccess(res);
    return VMyOrderInfo.fromMap(extractDataFromResponse(res));
  }

  Future<int> getRoomUnReadCount({required String roomId}) async {
    final res = await _channelApiService!.getRoomUnReadCount(roomId);
    throwIfNotSuccess(res);
    return (res.body as Map<String, dynamic>)['data'] as int;
  }

  Future<WebMetadata> getUrlPreview({
    required String roomId,
    required String url,
  }) async {
    final res = await _channelApiService!.getUrlPreview(roomId, {"url": url});
    throwIfNotSuccess(res);
    return WebMetadata.fromMap(extractDataFromResponse(res));
  }

  Future<bool> transTo({
    required String roomId,
    required String transTo,
  }) async {
    final res = await _channelApiService!.transTo(roomId, {"transTo": transTo});
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> stopRoomAutoTranslate({
    required String roomId,
  }) async {
    final res = await _channelApiService!.stopRoomAutoTranslate(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> deleteRoom(
    String roomId,
  ) async {
    final res = await _channelApiService!.deleteRoom(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<VPaginationModel<VRoom>> getRooms(VRoomsDto dto) async {
    final res = await _channelApiService!.getRooms(dto.toMap());
    throwIfNotSuccess(res);
    final data = extractDataFromResponse(res);
    return VPaginationModel<VRoom>.fromCustomMap(
      values: (data['docs'] as List)
          .map((e) => VRoom.fromMap(e as Map<String, dynamic>))
          .toList(),
      map: data,
    );
  }

  Future<bool> deliverRoomMessages(
    String roomId,
  ) async {
    final res = await _channelApiService!.deliverRoomMessages(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<VRoom> createBroadcast(
    CreateBroadcastDto dto,
  ) async {
    final res = await _channelApiService!.createBroadcast(
      dto.toListOfPartValue(),
      dto.platformImage == null
          ? null
          : await VPlatforms.getMultipartFile(
              source: dto.platformImage!,
            ),
    );
    throwIfNotSuccess(res);
    return VRoom.fromMap(
      extractDataFromResponse(res),
    );
  }

  Future<VMyBroadcastInfo> getBroadcastInfo(String roomId) async {
    final res = await _channelApiService!.getMyBroadcastInfo(roomId);
    throwIfNotSuccess(res);
    return VMyBroadcastInfo.fromMap(extractDataFromResponse(res));
  }

  Future<bool> updateBroadcastTitle({
    required String roomId,
    required String title,
  }) async {
    final res = await _channelApiService!.updateBroadcastTitle(roomId, {
      "title": title,
    });
    throwIfNotSuccess(res);
    return true;
  }

  Future<String> updateBroadcastImage({
    required String roomId,
    required VPlatformFile file,
  }) async {
    final res = await _channelApiService!.updateBroadcastImage(
      roomId,
      await VPlatforms.getMultipartFile(
        source: file,
      ),
    );
    throwIfNotSuccess(res);
    return (res.body as Map<String, dynamic>)['data'] as String;
  }

  Future<List<VBroadcastMember>> getBroadcastMembers({
    required String roomId,
    VBaseFilter? filter,
  }) async {
    final res = await _channelApiService!.getBroadcastMembers(
      roomId,
      filter == null ? {} : filter.toMap(),
    );
    throwIfNotSuccess(res);
    return (extractDataFromResponse(res)['docs'] as List)
        .map((e) => VBroadcastMember.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<SSearchUser>> getAvailableBroadcastMembersToAdded({
    required String roomId,
    UserFilterDto? filter,
  }) async {
    final res = await _channelApiService!.getAvailableBroadcastMembersToAdded(
      roomId,
      filter == null ? {} : filter.toMap(),
    );
    throwIfNotSuccess(res);
    return (extractDataFromResponse(res)['docs'] as List)
        .map((e) => SSearchUser.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<SSearchUser>> getAvailableGroupMembersToAdded({
    required String roomId,
    UserFilterDto? filter,
  }) async {
    final res = await _channelApiService!.getAvailableGroupMembersToAdded(
      roomId,
      filter == null ? {} : filter.toMap(),
    );
    throwIfNotSuccess(res);
    return (extractDataFromResponse(res)['docs'] as List)
        .map((e) => SSearchUser.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<bool> addParticipantsToBroadcast({
    required String roomId,
    required List<String> peerIds,
  }) async {
    final res = await _channelApiService!.addParticipantsToBroadcast(
      roomId,
      {"ids": peerIds},
    );
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> kickBroadcastUser({
    required String roomId,
    required String peerId,
  }) async {
    final res = await _channelApiService!.kickBroadcastUser(
      roomId,
      peerId,
    );
    throwIfNotSuccess(res);
    return true;
  }

  Future<VRoom> createGroup(
    CreateGroupDto dto,
  ) async {
    final res = await _channelApiService!.createGroup(
      dto.toListOfPartValue(),
      dto.platformImage == null
          ? null
          : await VPlatforms.getMultipartFile(
              source: dto.platformImage!,
            ),
    );
    throwIfNotSuccess(res);
    return VRoom.fromMap(extractDataFromResponse(res));
  }

  Future<bool> getGroupStatus(String roomId) async {
    final res = await _channelApiService!.getMyGroupStatus(roomId);
    throwIfNotSuccess(res);
    return extractDataFromResponse(res)['isMeOut'] as bool;
  }

  Future<VMyGroupInfo> getMyGroupInfo(String roomId) async {
    final res = await _channelApiService!.getMyGroupInfo(roomId);
    throwIfNotSuccess(res);
    return VMyGroupInfo.fromMap(extractDataFromResponse(res));
  }

  Future<List<VMentionModel>> searchToMention(
    String roomId, {
    required VBaseFilter filter,
  }) async {
    final res =
        await _channelApiService!.getGroupMembers(roomId, filter.toMap());
    throwIfNotSuccess(res);
    final list = extractDataFromResponse(res)['docs'] as List;
    final users = list
        .map(
          (e) => SBaseUser.fromMap(
            (e as Map<String, dynamic>)['userData'] as Map<String, dynamic>,
          ),
        )
        .toList();
    return users
        .map(
          (e) => VMentionModel(
            peerId: e.id,
            name: e.fullName,
            image: e.userImage,
          ),
        )
        .toList();
  }

  Future<bool> leaveGroup(String roomId) async {
    final res = await _channelApiService!.leaveGroup(roomId);
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> updateGroupTitle({
    required String roomId,
    required String title,
  }) async {
    final res = await _channelApiService!.updateGroupTitle(roomId, {
      "title": title,
    });
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> updateGroupDescription({
    required String roomId,
    required String description,
  }) async {
    final res = await _channelApiService!.updateGroupDescription(roomId, {
      "description": description,
    });
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> updateGroupExtraData({
    required String roomId,
    required Map<String, dynamic> data,
  }) async {
    final res = await _channelApiService!.updateGroupExtraData(roomId, data);
    throwIfNotSuccess(res);
    return true;
  }

  Future<List<VMessageStatusModel>> getMessageStatusForGroup({
    required String roomId,
    required String messageId,
    VBaseFilter? pagination,
    required bool isSeen,
  }) async {
    final res = await _channelApiService!.getMessageStatusForGroup(
      roomId,
      messageId,
      pagination == null ? {} : pagination.toMap(),
      isSeen ? "seen" : "deliver",
    );

    throwIfNotSuccess(res);
    final resList = extractDataFromResponse(res)['docs'] as List;
    return resList
        .map((e) => VMessageStatusModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<VMessageStatusModel>> getMessageStatusForBroadcast({
    required String roomId,
    required String messageId,
    VBaseFilter? pagination,
    required bool isSeen,
  }) async {
    final res = await _channelApiService!.getMessageStatusForBroadcast(
      roomId,
      messageId,
      pagination == null ? {} : pagination.toMap(),
      isSeen ? "seen" : "deliver",
    );

    throwIfNotSuccess(res);
    final resList = extractDataFromResponse(res)['docs'] as List;
    return resList
        .map((e) => VMessageStatusModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<String> updateGroupImage({
    required String roomId,
    required VPlatformFile file,
  }) async {
    final res = await _channelApiService!.updateGroupImage(
      roomId,
      await VPlatforms.getMultipartFile(
        source: file,
      ),
    );
    throwIfNotSuccess(res);
    return (res.body as Map<String, dynamic>)['data'] as String;
  }

  Future<List<VGroupMember>> getGroupMembers(
    String roomId, {
    VBaseFilter? filter,
  }) async {
    final res = await _channelApiService!.getGroupMembers(
      roomId,
      filter == null ? {} : filter.toMap(),
    );
    final data = extractDataFromResponse(res)['docs'] as List;
    return data
        .map((e) => VGroupMember.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<bool> addParticipantsToGroup({
    required String roomId,
    required List<String> ids,
  }) async {
    final res =
        await _channelApiService!.addParticipantsToGroup(roomId, {"ids": ids});
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> changeUserGroupRole({
    required String roomId,
    required String peerId,
    required VGroupMemberRole role,
  }) async {
    final res = await _channelApiService!.changeUserGroupRole(
      roomId,
      peerId,
      role.name,
    );
    throwIfNotSuccess(res);
    return true;
  }

  Future<bool> kickGroupUser({
    required String roomId,
    required String peerId,
  }) async {
    final res = await _channelApiService!.kickGroupUser(
      roomId,
      peerId,
    );
    throwIfNotSuccess(res);
    return true;
  }

  static VChannelApiService init({
    Uri? baseUrl,
    String? accessToken,
  }) {
    _channelApiService ??= ChannelApi.create(
      accessToken: accessToken,
      baseUrl: baseUrl ?? VAppConstants.baseUri,
    );
    return VChannelApiService._();
  }
}
