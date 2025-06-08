import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart' as c;
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:uuid/uuid.dart';
import 'package:v_chat_sdk_core/src/models/api_cache_model.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';
import 'package:v_platform/v_platform.dart';

enum _CallPermission { microphone, camera }

class CallKeepHandler {
  // Singleton implementation
  CallKeepHandler._internal();

  static final CallKeepHandler _instance = CallKeepHandler._internal();

  static CallKeepHandler get I => _instance;

  // Constants
  static const int _callValidityDuration = 30; // seconds
  VLocalNativeApi? _nativeLocal;

  // CallKeep Configuration and Event Handling
  Future<void> configureFlutterCallKeep(bool isBackground) async {
    if (VPlatforms.isMobile) {
      setEventHandler(isBackground);
    }
  }

  Future<void> acceptCall(VCallNotificationModel model) async {
    try {
      if (!await _checkRequiredPermissions(model.withVideo)) {
        return;
      }
      await _navigateToCallScreen(model);
    } catch (e) {
      _handleError('Error accepting call: $e');
    }
  }

  // Permission Handling
  Future<bool> _checkRequiredPermissions(bool isVideoCall) async {
    if (VPlatforms.isWeb) return true;

    if (isVideoCall) {
      if (!await _requestPermissions(
          [_CallPermission.microphone, _CallPermission.camera])) {
        _showPermissionError(true);
        return false;
      }
    } else {
      if (!await _requestPermissions([_CallPermission.microphone])) {
        _showPermissionError(false);
        return false;
      }
    }
    return true;
  }

  Future<bool> _requestPermissions(List<_CallPermission> permissions) async {
    for (final permission in permissions) {
      final granted = await _requestSinglePermission(permission);
      if (!granted) return false;
    }
    return true;
  }

  Future<bool> _requestSinglePermission(_CallPermission permission) async {
    final Permission permissionType = permission == _CallPermission.microphone
        ? Permission.microphone
        : Permission.camera;

    final result = await permissionType.request();
    return result == PermissionStatus.granted;
  }

  Future<String?> getVoipIos() async {
    if (!VPlatforms.isIOS) return null;
    return await FlutterCallkitIncoming.getDevicePushTokenVoIP() as String?;
  }

  Future<void> startShowCallKeep({
    required VCallNotificationModel model,
    required bool fromBackground,
    VLocalNativeApi? nativeLocal,
  }) async {
    try {
      if (fromBackground) await configureFlutterCallKeep(fromBackground);
      _nativeLocal = nativeLocal;
      final callEvent = await _createCallEvent2(model);
      if (VPlatforms.isAndroid) {
        await FlutterCallkitIncoming.showCallkitIncoming(callEvent);
      }
    } catch (e) {
      _handleError('Error showing call: $e');
    }
  }

  Future<CallKitParams> _createCallEvent2(VCallNotificationModel model) async {
    AppConfigModel config = AppConfigModel.init();
    await VAppPref.init();
    final cachedConfig = VAppPref.getMap(SStorageKeys.appConfigModelData.name);
    if (cachedConfig != null) {
      config = AppConfigModel.fromMap(cachedConfig);
    }

    final isGroup = model.roomType == VRoomType.g;

    return CallKitParams(
      id: const Uuid().v4(),
      nameCaller: model.userName,
      appName: 'ChatCed',
      avatar: "${SConstants.baseMediaUrl}${model.userImage}",
      handle:
          'incoming ${isGroup ? "${model.groupName}" : ""} ${model.withVideo ? "video" : "voice"}',
      type: model.withVideo ? 1 : 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: const NotificationParams(
        showNotification: false,
        isShowCallback: false,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      duration: config.callTimeout,
      extra: model.toMap(),
      android: AndroidParams(
        isCustomNotification: false,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: "${SConstants.baseMediaUrl}${model.userImage}",
        actionColor: '#4CAF50',
        textColor: '#ffffff',
        isImportant: true,
        incomingCallNotificationChannelName: "Incoming Call",
        missedCallNotificationChannelName: "Missed Call",
        isShowCallID: false,
      ),
      ios: IOSParams(
        iconName: 'LaunchImage',
        handleType: 'generic',
        supportsVideo: model.withVideo,
        maximumCallGroups: 2,
        // Maximum calls in a single group
        maximumCallsPerCallGroup: isGroup ? 20 : 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
        configureAudioSession: true,
      ),
    );
  }

  // Call Status Checking
  Future<void> checkLastCall() async {
    try {
      final callData = await _getStoredCallData();
      if (callData == null) return;

      if (_shouldProcessCall(callData)) {
        await _processStoredCall(callData);
      }
    } catch (e) {
      _handleError('Error checking last call: $e');
    }
  }

  bool _shouldProcessCall(CallKitBackgroundCallModel model) {
    return !model.isProcessed && model.isAccepted && _isCallValid(model.date);
  }

  bool _isCallValid(DateTime date) {
    final callAge = DateTime.now().difference(date);
    return callAge.inSeconds <= _callValidityDuration;
  }

  Future<void> _handleCallDeclinedBackground2(
      Map<String, dynamic> event) async {
    final nativeLocal = VLocalNativeApi();
    await nativeLocal.init();
    final model = VCallNotificationModel.fromMap(event);
    await _storeCallData(model, false);
    await VAppPref.init();
    final baseUrl = VAppPref.getStringOrNullKey("vBaseUrl");
    final res = await post(
      Uri.parse(
        "$baseUrl/call/end/v2/${model.callId}",
      ),
      headers: {
        'authorization':
            "Bearer ${VAppPref.getHashedString(key: "vAccessToken")}",
        "clint-version": "2.0.0",
        "Accept-Language": "en"
      },
    );
    if (res.statusCode != 200) {
      throw "cant _handleCallDeclinedBackground in background for ${res.body}";
    }
  }

  Future<void> _storeCallData(
    VCallNotificationModel vModel,
    bool isAccepted,
  ) async {
    final model = CallKitBackgroundCallModel(
      date: DateTime.now(),
      isAccepted: isAccepted,
      isProcessed: !isAccepted,
      model: vModel,
    );
    await _nativeLocal?.apiCache.insertToApiCache(
      ApiCacheModel(
        endPoint: SStorageKeys.lastAcceptedCall.name,
        value: model.toMap(),
      ),
    );
  }

  Future<CallKitBackgroundCallModel?> _getStoredCallData() async {
    final cacheModel = await VChatController.I.nativeApi.local.apiCache
        .getOneApiCache(SStorageKeys.lastAcceptedCall.name);
    if (cacheModel == null) return null;

    // final map = VAppPref.getMap(SStorageKeys.lastAcceptedCall.name);
    return CallKitBackgroundCallModel.fromMap(cacheModel.value);
  }

  Future<void> _processStoredCall(CallKitBackgroundCallModel model) async {
    await VChatController.I.nativeApi.local.apiCache.insertToApiCache(
      ApiCacheModel(
        endPoint: SStorageKeys.lastAcceptedCall.name,
        value: model.copyWith(isProcessed: true).toMap(),
      ),
    );
    await acceptCall(model.model);
  }

  Future<void> _navigateToCallScreen(VCallNotificationModel model) async {
    VChatController.I.vNavigator.callNavigator.toCall(
      VChatController.I.navigationContext,
      VCallDto(
        isVideoEnable: model.withVideo,
        roomId: model.roomId,
        callId: model.callId,
        peerUser: SBaseUser(
          id: model.callId,
          fullName: model.userName,
          userImage: model.userImage,
        ),
        isCaller: false,
      ),
    );
  }

  void _showPermissionError(bool isVideoCall) {
    VAppAlert.showErrorSnackBarWithoutContext(
      message: isVideoCall
          ? S.current.microphoneAndCameraPermissionMustBeAccepted
          : S.current.microphonePermissionMustBeAccepted,
    );
  }

  void _handleError(String message) {
    debugPrint(message);
    // Add your error handling logic here (e.g., analytics, logging)
  }

  // Public Methods
  Future<void> endCalls(String? roomId) async {
    try {
      await FlutterCallkitIncoming.endAllCalls();

      // await CallKeep.instance.endAllCalls();
    } catch (e) {
      _handleError('Error ending calls: $e');
    }
  }

  Future<void> setEventHandler(bool background) async {
    FlutterCallkitIncoming.onEvent.listen((c.CallEvent? event) async {
      switch (event!.event) {
        case c.Event.actionCallIncoming:
          // TODO: received an incoming call
          break;
        case c.Event.actionCallStart:
          // TODO: started an outgoing call
          // TODO: show screen calling in Flutter
          break;
        case c.Event.actionCallAccept:
          final Map<String, dynamic> extraMap =
              (event.body['extra'] as Map).cast<String, dynamic>();
          final model = VCallNotificationModel.fromMap(extraMap);
          if (VPlatforms.isIOS || !background) {
            acceptCall(model);
            return;
          }

          await _storeCallData(model, true);
        case c.Event.actionCallDecline:
          final Map<String, dynamic> extraMap =
              (event.body['extra'] as Map).cast<String, dynamic>();
          _handleCallDeclinedBackground2(extraMap);

        case c.Event.actionCallEnded:
          // TODO: ended an incoming/outgoing call
          break;
        case c.Event.actionCallTimeout:
          // TODO: missed an incoming call
          break;
        case c.Event.actionCallCallback:
          // TODO: only Android - click action `Call back` from missed call notification
          break;
        case c.Event.actionCallToggleHold:
          // TODO: only iOS
          break;
        case c.Event.actionCallToggleMute:
          // TODO: only iOS
          break;
        case c.Event.actionCallToggleDmtf:
          // TODO: only iOS
          break;
        case c.Event.actionCallToggleGroup:
          // TODO: only iOS
          break;
        case c.Event.actionCallToggleAudioSession:
          // TODO: only iOS
          break;
        case c.Event.actionDidUpdateDevicePushTokenVoip:
        case c.Event.actionCallCustom:
          // TODO: for custom action
          break;
      }
    });
  }
}
