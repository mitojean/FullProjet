// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ChannelApi extends ChannelApi {
  _$ChannelApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ChannelApi;

  @override
  Future<Response<dynamic>> getPeerRoom(String peerId) {
    final Uri $url = Uri.parse('channel/peer-room/${peerId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllStarMessages() {
    final Uri $url = Uri.parse('channel/messages/stars');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateRoomNickName(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/nick-name');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRoomById(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> muteRoomNotification(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/notification/mute');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> unMuteRoomNotification(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/notification/un-mute');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> oneSeenOff(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/one-seen/off');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> oneSeenOn(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/one-seen/on');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> archiveRoom(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/archive');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> unArchiveRoom(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/un-archive');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRoomUnReadCount(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/un-read-count');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUrlPreview(
    String roomId,
    Map<String, dynamic> query,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/url-preview');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> transTo(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/translate');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> stopRoomAutoTranslate(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/translate/stop');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteRoom(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRooms(Map<String, dynamic> query) {
    final Uri $url = Uri.parse('channel/');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deliverRoomMessages(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/deliver');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createBroadcast(
    List<PartValue<dynamic>> body,
    MultipartFile? file,
  ) {
    final Uri $url = Uri.parse('channel/broadcast');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile?>(
        'file',
        file,
      )
    ];
    $parts.addAll(body);
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateBroadcastTitle(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/title');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateBroadcastImage(
    String roomId,
    MultipartFile file,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/image');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBroadcastMembers(
    String roomId,
    Map<String, dynamic> query,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/members');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAvailableBroadcastMembersToAdded(
    String roomId,
    Map<String, dynamic> query,
  ) {
    final Uri $url =
        Uri.parse('channel/${roomId}/broadcast/available-users-to-add');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addParticipantsToBroadcast(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/members');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> kickBroadcastUser(
    String roomId,
    String peerId,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/members/${peerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyBroadcastInfo(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/my-info');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMessageStatusForBroadcast(
    String roomId,
    String mId,
    Map<String, dynamic> query,
    String type,
  ) {
    final Uri $url =
        Uri.parse('channel/${roomId}/broadcast/message/${mId}/status/${type}');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createGroup(
    List<PartValue<dynamic>> body,
    MultipartFile? file,
  ) {
    final Uri $url = Uri.parse('channel/group');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile?>(
        'file',
        file,
      )
    ];
    $parts.addAll(body);
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> leaveGroup(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/group/leave');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateGroupTitle(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/title');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateGroupDescription(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/description');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAvailableGroupMembersToAdded(
    String roomId,
    Map<String, dynamic> query,
  ) {
    final Uri $url =
        Uri.parse('channel/${roomId}/group/available-users-to-add');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMessageStatusForGroup(
    String roomId,
    String mId,
    Map<String, dynamic> query,
    String type,
  ) {
    final Uri $url =
        Uri.parse('channel/${roomId}/group/message/${mId}/status/${type}');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateGroupExtraData(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/extra-data');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateGroupImage(
    String roomId,
    MultipartFile file,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/image');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyGroupInfo(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/group/my-info');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyGroupStatus(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/group/my-status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getGroupMembers(
    String roomId,
    Map<String, dynamic> query,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/members');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addParticipantsToGroup(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/members');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changeUserGroupRole(
    String roomId,
    String peerId,
    String role,
  ) {
    final Uri $url =
        Uri.parse('channel/${roomId}/group/members/${peerId}/${role}');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> kickGroupUser(
    String roomId,
    String peerId,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/members/${peerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOrderRoomInfo(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/group/members');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
