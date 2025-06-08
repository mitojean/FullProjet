// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_up/app/modules/home/mobile/settings_tab/widgets/settings_list_item_tile.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:s_translation/generated/l10n.dart';

import '../../../../../../core/models/user_device_model.dart';
import '../controllers/linked_devices_controller.dart';

class LinkedDevicesPage extends StatefulWidget {
  const LinkedDevicesPage({super.key});

  @override
  State<LinkedDevicesPage> createState() => _LinkedDevicesPageState();
}

class _LinkedDevicesPageState extends State<LinkedDevicesPage> {
  late final LinkedDevicesController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDark ? null : CupertinoColors.systemGrey6,
      appBar: AppBar(
        title: Text(S.of(context).linkedDevices),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoListSection.insetGrouped(
                  additionalDividerMargin: 0,
                  margin: const EdgeInsets.all(10),
                  dividerMargin: 0,
                  topMargin: 0,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Image.asset(
                              "assets/connect_web.png",
                              height: 200,
                              width: 250,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("User ${SConstants.appName} on Web,",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey)),
                            Text(
                              S.of(context).desktopAndOtherDevices,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                            CupertinoButton(
                              child: Text(
                                S.of(context).linkADeviceSoon,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                ValueListenableBuilder<SLoadingState<List<UserDeviceModel>>>(
                  valueListenable: controller,
                  builder: (_, value, ___) => VAsyncWidgetsBuilder(
                    loadingState: value.loadingState,
                    onRefresh: controller.getData,
                    successWidget: () {
                      return CupertinoListSection.insetGrouped(
                        additionalDividerMargin: 0,
                        header: Text(
                          S.of(context).linkedDevices,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        footer: Text(
                          S.of(context).tapADeviceToEditOrLogOut,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        margin: const EdgeInsets.all(10),
                        dividerMargin: 0,
                        topMargin: 0,
                        children: value.data
                            .map(
                              (e) => SettingsListItemTile(
                                color: _getColor(e.platform),
                                icon: _getIcon(e.platform),
                                subtitle: Text(
                                  "${S.of(context).lastActiveFrom} ${format(e.lastSeenAtLocal, locale: Localizations.localeOf(context).languageCode)}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                                title: e.platform,
                                onTap: () => controller.onDeviceTap(context, e),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = LinkedDevicesController();
    controller.onInit();
  }

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  IconData _getIcon(String platform) {
    if (platform == "android" || platform == "ios") {
      return PhosphorIcons.deviceMobile();
    }
    if (platform == "web") {
      return PhosphorIcons.googleChromeLogo();
    }
    if (platform == "macOs" || platform == "windows") {
      return PhosphorIcons.computerTower();
    }
    return Icons.question_mark;
  }

  Color _getColor(String platform) {
    if (platform == "android" || platform == "ios") {
      return Colors.green;
    }
    if (platform == "web") {
      return Colors.orange;
    }
    if (platform == "macOs" || platform == "windows") {
      return Colors.blueAccent;
    }
    return Colors.red;
  }
}
