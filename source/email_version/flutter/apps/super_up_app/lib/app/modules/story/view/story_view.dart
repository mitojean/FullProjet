import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:super_up/app/core/api_service/story/story_api_service.dart';
import 'package:super_up/app/core/models/story/story_model.dart';
import 'package:super_up/app/modules/peer_profile/views/peer_profile_view.dart';
import 'package:super_up_core/super_up_core.dart';
import 'package:v_platform/v_platform.dart';

import '../../../core/utils/enums.dart';

class StoryViewpage extends StatefulWidget {
  final UserStoryModel storyModel;
  final Function(UserStoryModel current)? onComplete;
  final Function()? onDelete;

  const StoryViewpage({
    super.key,
    required this.storyModel,
    required this.onComplete,
    required this.onDelete,
  });

  @override
  State<StoryViewpage> createState() => _StoryViewpageState();
}

class _StoryViewpageState extends State<StoryViewpage> {
  final controller = StoryController();

  final stories = <StoryItem>[];
  late StoryModel current = widget.storyModel.stories.first;
  final _api = GetIt.I.get<StoryApiService>();

  @override
  void initState() {
    _parseStories();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            StoryView(
              onComplete: () {
                context.pop();
                widget.onComplete?.call(widget.storyModel);
              },
              onStoryShow: (storyItem, index) {
                int pos = stories.indexOf(storyItem);
                current = widget.storyModel.stories[pos];
                unawaited(_setSeen(current.id));
                if (pos == 0) return;
                setState(() {});
              },
              storyItems: stories,
              controller: controller,
            ),
            Positioned(
              top: 25,
              left: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.storyModel.userData.isMe) return;
                      context.toPage(
                        PeerProfileView(peerId: widget.storyModel.userData.id),
                      );
                    },
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        VCircleAvatar(
                          vFileSource: VPlatformFile.fromUrl(
                            networkUrl: widget.storyModel.userData.userImage,
                          ),
                          radius: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.storyModel.userData.fullName.text.black
                                .color(Colors.white),
                            const SizedBox(
                              height: 3,
                            ),
                            format(
                              DateTime.parse(current.createdAt),
                              locale:
                                  Localizations.localeOf(context).languageCode,
                            ).cap.color(Colors.white),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.storyModel.userData.isMe)
              Positioned(
                right: 3,
                top: 20,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PopupMenuButton<int>(
                      icon: Icon(
                        Icons.more_vert_sharp,
                        size: 30,
                        color: Colors.white,
                      ),
                      onSelected: (int result) async {
                        if (result == 1) {
                          final x = await VAppAlert.showAskYesNoDialog(
                            context: context,
                            title: S.of(context).delete,
                            content: S.of(context).areYouSure,
                          );
                          if (x == 1) {
                            await GetIt.I
                                .get<StoryApiService>()
                                .deleteStory(current.id);
                            VAppAlert.showSuccessSnackBar(
                                message: S.of(context).deleted,
                                context: context);
                            if (widget.onDelete != null) {
                              widget.onDelete!();
                            }

                            context.pop();
                          }
                          // Perform delete action here
                          print('Delete button pressed');
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<int>>[
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Future _setSeen(String id) async {
    vSafeApiCall(
      request: () async {
        await _api.setSeen(current.id);
      },
      onSuccess: (response) {},
    );
  }

  void _parseStories() {
    for (final story in widget.storyModel.stories) {
      if (story.storyType == StoryType.image) {
        stories.add(
          StoryItem.pageImage(
            url: VPlatformFile.fromUrl(networkUrl: story.att!['url']!)
                .fullNetworkUrl!,
            controller: controller,
            caption: story.caption == null ? null : Text(story.caption!),
            duration: const Duration(seconds: 7),
            imageFit: BoxFit.contain,
          ),
        );
        continue;
      }
      if (story.storyType == StoryType.text) {
        stories.add(
          StoryItem.text(
            title: story.content,
            duration: const Duration(seconds: 10),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontStyle: story.fontType == StoryFontType.italic
                  ? FontStyle.italic
                  : null,
              textBaseline: TextBaseline.alphabetic,
              fontWeight:
                  story.fontType == StoryFontType.bold ? FontWeight.bold : null,
            ),
            backgroundColor: story.colorValue == null
                ? Colors.green
                : Color(story.colorValue!),
          ),
        );
        continue;
      }
    }
  }
}
