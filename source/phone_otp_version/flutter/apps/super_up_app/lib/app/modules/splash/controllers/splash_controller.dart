// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:developer';

import 'package:background_downloader/background_downloader.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';
import 'package:v_platform/v_platform.dart';

import '../../../../main.dart';
import '../../../core/app_config/app_config_controller.dart';
import '../../auth/login/views/qr_code_web_screen.dart';
import '../../auth/phone_login/phone_authentication.dart';
import '../../auth/waiting_list/views/waiting_list_page.dart';
import '../../home/home_controller/views/home_view.dart';
import '../views/splash_view.dart';

bool isShow450Error = false;

class SplashController extends SLoadingController<String> {
  String get version => data;

  SplashController() : super(SLoadingState(""));

  BuildContext get context => navigatorKey.currentState!.context;
  final appConfigController = GetIt.I.get<VAppConfigController>();

  @override
  void onInit() {
    getAppVersion();
    startNavigate();
    _init450Listener();
    // checkUpdates();
  }

  void _init450Listener() async {
    // await Future.delayed(const Duration(milliseconds: 100));
    try {
      unAuthStream450Error.stream.listen((event) async {
        if (isShow450Error == true) return;
        isShow450Error = true;
        await Future.delayed(const Duration(seconds: 1));
        await VChatController.I.profileApi.logout();
        AppAuth.setProfileNull();
        await VAppPref.clear();
        await VAppAlert.showOkAlertDialog(
          context: context,
          title: S.of(context).loginAgain,
          content: S.of(context).yourSessionIsEndedPleaseLoginAgain,
        );

        VChatController.I.navigatorKey.currentContext!.toPage(
          const SplashView(),
          withAnimation: false,
          removeAll: true,
        );
        AppAuth.setProfileNull();
      });
    } catch (err) {
      //
    }
  }

  Future<void> getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final version = packageInfo.version;
      final buildNumber = packageInfo.buildNumber;
      value.data = "$version+$buildNumber";
      setStateSuccess();
      await appConfigController.refreshAppConfig();
      final c = VAppConfigController.appConfig;
      VChatController.I.updateConfig(VChatController.I.vChatConfig.copyWith(
        maxForward: c.maxForward,
        maxBroadcastMembers: c.maxBroadcastMembers,
        maxGroupMembers: c.maxGroupMembers,
      ));
    } catch (err) {
      log(err.toString());
    }
  }

  void _homeNav() {
    context.toPageAndRemoveAllWithOutAnimation(const HomeView());
  }

  void startNavigate() async {
    if (VPlatforms.isDeskTop) {
      await _setDesktopAutoUpdater();
    }
    if (VPlatforms.isMobile) {
      await VFileUtils.refreshAppPath();
      await FileDownloader().trackTasks();
      FileDownloader().configureNotificationForGroup(
        "files",
        running:
            const TaskNotification(SConstants.appName, 'File 📁 : {filename}'),
        progressBar: true,
        tapOpensFile: true,
      );
    }

    await Future.delayed(const Duration(milliseconds: 650));

    final isLogin = VAppPref.getBool(SStorageKeys.isLogin.name);
    if (isLogin) {
      _homeNav();
      return;
    }
    final map = VAppPref.getMap(SStorageKeys.myProfile.name);
    if (map == null) {
      if (VPlatforms.isDeskTop || VPlatforms.isWeb) {
        return context.toPage(
          const QrCodeWebScreen(),
          withAnimation: true,
          removeAll: true,
        );
      }

      context.toPage(
        const PhoneAuthentication(),
        withAnimation: true,
        removeAll: true,
      );
      return;
    }
    final myProfile = SMyProfile.fromMap(map);
    if (myProfile.registerStatus == RegisterStatus.accepted) {
      _homeNav();
    } else {
      context.toPage(
        WaitingListPage(
          profile: myProfile,
        ),
        withAnimation: true,
        removeAll: true,
      );
    }
  }

  @override
  void onClose() {}

  Future _setDesktopAutoUpdater() async {}

// void checkUpdates() async {
//   if (VPlatforms.isMobile) {
//     final newVersionPlus = NewVersionPlus();
//     try {
//       await newVersionPlus.showAlertIfNecessary(
//           context: navigatorKey.currentState!.context);
//     } catch (err) {
//       if (kDebugMode) print(err);
//     }
//   }
// }
}
