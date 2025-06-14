// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$BlockApi extends BlockApi {
  _$BlockApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = BlockApi;

  @override
  Future<Response<dynamic>> banUser(String peerId) {
    final Uri $url = Uri.parse('user-ban/${peerId}/ban');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> unBanUser(String peerId) {
    final Uri $url = Uri.parse('user-ban/${peerId}/un-ban');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> checkBan(String peerId) {
    final Uri $url = Uri.parse('user-ban/${peerId}/ban');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
