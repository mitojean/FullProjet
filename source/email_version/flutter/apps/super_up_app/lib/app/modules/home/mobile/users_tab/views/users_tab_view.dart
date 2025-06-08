// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loadmore/loadmore.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:v_platform/v_platform.dart';

import '../../../../../core/app_config/app_config_controller.dart';
import '../controllers/users_tab_controller.dart';

class UsersTabView extends StatefulWidget {
  const UsersTabView({super.key});

  @override
  State<UsersTabView> createState() => _UsersTabViewState();
}

class _UsersTabViewState extends State<UsersTabView> {
  late final UsersTabController controller;

  @override
  void initState() {
    super.initState();
    controller = GetIt.I.get<UsersTabController>();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              largeTitle: Text(S.of(context).users),
              trailing: ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, child) {
                  if (controller.isSearchOpen) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: CupertinoSearchTextField(
                              controller: controller.searchController,
                              onChanged: controller.onSearchChanged,
                              focusNode: controller.searchFocusNode,
                            ),
                          ),
                          TextButton(
                            onPressed: controller.closeSearch,
                            child: Text(S.of(context).close),
                          )
                        ],
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: controller.openSearch,
                    child: const Icon(
                      CupertinoIcons.search,
                      size: 28,
                    ),
                  );
                },
              ),
            )
          ];
        },
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              AdsBannerWidget(
                adsId: VPlatforms.isAndroid
                    ? SConstants.androidBannerAdsUnitId
                    : SConstants.iosBannerAdsUnitId,
                isEnableAds: VAppConfigController.appConfig.enableAds,
              ),
              Expanded(
                child: ValueListenableBuilder<SLoadingState<List<SSearchUser>>>(
                  valueListenable: controller,
                  builder: (_, value, __) {
                    return VAsyncWidgetsBuilder(
                      loadingState: value.loadingState,
                      onRefresh: controller.getUsersDataFromApi,
                      successWidget: () {
                        return RefreshIndicator(
                          onRefresh: controller.getUsersDataFromApi,
                          child: LoadMore(
                            onLoadMore: controller.onLoadMore,
                            isFinish: controller.isFinishLoadMore,
                            textBuilder: (status) => "",
                            child: ListView.separated(
                              cacheExtent: 300,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 9,
                              ),
                              itemBuilder: (context, index) {
                                final item = controller.data[index];
                                return SUserItem(
                                  onTap: () =>
                                      controller.onItemPress(item, context),
                                  baseUser: item.baseUser,
                                  hasBadge: item.hasBadge,
                                  subtitle: item.getUserBio,
                                  trailing: const Icon(CupertinoIcons.forward),
                                );
                              },
                              itemCount: controller.data.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 10,
                                  thickness: 1,
                                  color: Colors.grey.withValues(alpha: .2),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
