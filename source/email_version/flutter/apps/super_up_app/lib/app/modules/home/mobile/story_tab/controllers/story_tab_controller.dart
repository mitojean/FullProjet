// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:v_chat_media_editor/v_chat_media_editor.dart';
import 'package:v_platform/v_platform.dart';

import '../../../../../core/api_service/story/story_api_service.dart';
import '../../../../../core/models/story/story_model.dart';
import '../../../../../core/utils/permission_manager.dart';
import '../../../../story/media_story/create_media_story.dart';
import '../../../../story/text_story/create_text_story.dart';

class StoryTabState {
  List<UserStoryModel> allStories = [];
  UserStoryModel myStories =
      UserStoryModel(stories: [], userData: AppAuth.myProfile.baseUser);
  bool isMyStoriesLoading = false;
}

class StoryTabController extends SLoadingController<StoryTabState> {
  StoryTabController() : super(SLoadingState(StoryTabState()));
  final _apiService = GetIt.I.get<StoryApiService>();
  Timer? _timer;

  @override
  void onInit() {
    getStories();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      getStoriesFromApi();
    });
    getMyStoryFromApi();
  }

  @override
  void onClose() {
    _timer?.cancel();
  }

  void getStories() async {
    try {
      final oldStories = VAppPref.getMap("api/stories/all");
      if (oldStories != null) {
        final list = oldStories['data'] as List;
        data.allStories = list.map((e) => UserStoryModel.fromMap(e)).toList();
        setStateSuccess();
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
    await getStoriesFromApi();
  }

  Future<void> getStoriesFromApi() async {
    vSafeApiCall(
      request: () {
        return _apiService.getUsersStories(page: 1, limit: 50);
      },
      onSuccess: (response) {
        for (int i = response.length - 1; i >= 0; i--) {
          var item = response[i];
          if (!data.allStories.contains(item)) {
            data.allStories.insert(0, item);
          }
        }
        if (response.isEmpty) {
          data.allStories.clear();
          unawaited(VAppPref.removeKey("api/stories/all"));
        } else {
          unawaited(VAppPref.setMap("api/stories/all", {
            "data": response.map((e) => e.toMap()).toList(),
          }));
        }
        setStateSuccess();
        update();
      },
    );
  }

  Future getMyStoryFromApi() async {
    vSafeApiCall<UserStoryModel?>(
      request: () {
        return _apiService.getMyStories();
      },
      onSuccess: (response) {
        if (response == null) return;
        data.myStories = response;
        setStateSuccess();
        update();
      },
    );
  }

  void toCreateStory(BuildContext context) async {
    final res = await VAppAlert.showModalSheetWithActions(
      content: [
        ModelSheetItem(
          title: S.of(context).createTextStory,
          id: "1",
        ),
        ModelSheetItem(
          title: S.of(context).createMediaStory,
          id: "2",
        ),
      ],
      context: context,
    );
    if (res == null) return;
    if (res.id == "1") {
      await context.toPage(
        const CreateTextStory(),
      );
    }
    if (res.id == "2") {
      final res = await _processPickImage(context);
      if (res == null) return;
      final image = await VAppPick.getImage(isFromCamera: res == 1);
      if (image == null) return;
      final mediaAfterEdit = await onSubmitMedia(context, [image]);
      if (mediaAfterEdit == null) return;
      await context.toPage(
        CreateMediaStory(
          media: mediaAfterEdit,
        ),
      );
    }
    getMyStoryFromApi();
  }

  Future<VPlatformFile?> _onCameraPress(BuildContext context) async {
    final isCameraAllowed = await PermissionManager.isCameraAllowed();
    if (!isCameraAllowed) {
      final x = await PermissionManager.askForCamera();
      if (!x) return null;
    }
    final entity = await VAppPick.pickFromWeAssetCamera(
      context: context,
    );
    if (entity == null) return null;
    return entity;
  }

  Future<VBaseMediaRes?> onSubmitMedia(
    BuildContext context,
    List<VPlatformFile> files,
  ) async {
    final fileRes = await context.toPage(VMediaEditorView(
      files: files,
    )) as List<VBaseMediaRes>?;
    if (fileRes == null || fileRes.isEmpty) return null;
    return fileRes.first;
  }

  Future<int?> _processPickImage(BuildContext context) async {
    final res = await VAppAlert.showModalSheetWithActions(
      content: [
        ModelSheetItem(
          title: S.of(context).camera,
          id: "1",
        ),
        ModelSheetItem(
          title: S.of(context).gallery,
          id: "2",
        ),
      ],
      context: context,
    );
    if (res == null) return null;
    return res.id == "1" ? 1 : 2;
  }
}
