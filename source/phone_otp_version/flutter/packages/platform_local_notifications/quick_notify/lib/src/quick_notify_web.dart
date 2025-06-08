import 'package:web/web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:quick_notify/src/quick_notify_platform_interface.dart';
import 'dart:js_interop'; // Required for handling JS interop

const _permissionGranted = 'granted';

class QuickNotifyWeb extends QuickNotifyPlatform {
  static void registerWith(Registrar registrar) {
    QuickNotifyPlatform.instance = QuickNotifyWeb();
  }

  @override
  Future<bool> hasPermission() async {
    return Notification.permission == _permissionGranted;
  }

  @override
  Future<bool> requestPermission() async {
    // Handle the promise returned by requestPermission
    final result = await Notification.requestPermission().toDart;
    // Convert JSString to Dart String
    final permission = (result).toDart;
    return permission == _permissionGranted;
  }

  @override
  Future<void> notify({
    required String title,
    String? content,
  }) async {
    // Use NotificationOptions for additional parameters
    final options = NotificationOptions(
      body: content ?? '',
    );
    Notification(title, options);
  }
}
