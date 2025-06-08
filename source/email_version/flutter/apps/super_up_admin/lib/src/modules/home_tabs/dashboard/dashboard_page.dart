// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up_admin/src/modules/home_tabs/dashboard/widgets/dash_info_item.dart';
import 'package:super_up_core/super_up_core.dart';

import 'dashboard_controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  final controller = DashboardController();

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  SliverGridDelegateWithFixedCrossAxisCount get gridDelegate =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.4),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      );

  Widget _buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
    List<DashGridItemModel> data,
  ) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // And slide transition
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        // Paste you Widget
        child: Card(
          child: DashInfoItem(
            dashGridItemModel: data[index],
          ),
        ),
      ),
    );
  }

  Widget getDivider(String title, int number) {
    final formattedNumber = number.numeral();
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        ("$title $formattedNumber").h4,
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: value.loadingState == VChatLoadingState.loading,
                    child: const LinearProgressIndicator(),
                  ),
                  "${S.of(context).users} ${controller.data.usersData.totalUsersCount}"
                      .h4,
                  const SizedBox(
                    height: 20,
                  ),
                  LiveGrid(
                    shrinkWrap: true,
                    showItemDuration: const Duration(milliseconds: 100),
                    showItemInterval: const Duration(milliseconds: 100),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.usersListItem.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: (context, index, animation) =>
                        _buildAnimatedItem(context, index, animation,
                            controller.usersListItem),
                  ),
                  getDivider(
                      S.of(context).devices, controller.data.usersDevices.all),
                  LiveGrid(
                    shrinkWrap: true,
                    showItemDuration: const Duration(milliseconds: 100),
                    showItemInterval: const Duration(milliseconds: 100),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.devicesListItem.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: (context, index, animation) =>
                        _buildAnimatedItem(context, index, animation,
                            controller.devicesListItem),
                  ),
                  getDivider(S.of(context).visits,
                      controller.data.usersCountries.length),
                  LiveGrid(
                    shrinkWrap: true,
                    showItemDuration: const Duration(milliseconds: 100),
                    showItemInterval: const Duration(milliseconds: 100),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.statistics.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: (context, index, animation) =>
                        _buildAnimatedItem(
                            context, index, animation, controller.statistics),
                  ),
                  getDivider(S.of(context).messageCounter,
                      controller.data.messagesCounter.messages),
                  LiveGrid(
                    shrinkWrap: true,
                    showItemDuration: const Duration(milliseconds: 100),
                    showItemInterval: const Duration(milliseconds: 100),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.messagesCounter.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: (context, index, animation) =>
                        _buildAnimatedItem(
                      context,
                      index,
                      animation,
                      controller.messagesCounter,
                    ),
                  ),
                  getDivider(S.of(context).roomCounter,
                      controller.data.roomCounter.total),
                  LiveGrid(
                    shrinkWrap: true,
                    showItemDuration: const Duration(milliseconds: 100),
                    showItemInterval: const Duration(milliseconds: 100),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.roomCounter.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: (context, index, animation) =>
                        _buildAnimatedItem(
                            context, index, animation, controller.roomCounter),
                  ),
                  getDivider(S.of(context).countries,
                      controller.data.usersCountries.length),
                  LiveGrid(
                    shrinkWrap: true,
                    showItemDuration: const Duration(milliseconds: 100),
                    showItemInterval: const Duration(milliseconds: 100),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.countryListItem.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: (context, index, animation) =>
                        _buildAnimatedItem(context, index, animation,
                            controller.countryListItem),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
