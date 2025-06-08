// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gal/gal.dart';
import 'package:s_translation/generated/l10n.dart';
import 'package:v_platform/v_platform.dart';
import 'package:video_player/video_player.dart';

import '../v_chat/v_file.dart';
import 'conditional_builder.dart';
import 'v_app_alert.dart';
import 'v_safe_api_call.dart';

class VVideoPlayer extends StatefulWidget {
  final VPlatformFile platformFileSource;
  final String downloadingLabel;
  final bool showDownload;
  final String successfullyDownloadedInLabel;

  const VVideoPlayer({
    super.key,
    required this.platformFileSource,
    required this.downloadingLabel,
    required this.showDownload,
    required this.successfullyDownloadedInLabel,
  });

  @override
  State<VVideoPlayer> createState() => _VVideoPlayerState();
}

class _VVideoPlayerState extends State<VVideoPlayer> {
  bool isLoading = true;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initAndPlay();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.platformFileSource.isContentVideo) {
      return Material(
          child: Text("the file must be video ${widget.platformFileSource}"));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: !widget.showDownload
          ? const SizedBox.shrink()
          : FloatingActionButton(
              child: const Icon(Icons.save_alt),
              onPressed: () async {
                await vSafeApiCall<String>(
                  onLoading: () {
                    VAppAlert.showSuccessSnackBar(
                      message: widget.downloadingLabel,
                      context: context,
                    );
                  },
                  request: () async {
                    if (VPlatforms.isMobile) {
                      if (!await Gal.hasAccess()) {
                        await Gal.requestAccess();
                      }
                      final path = await DefaultCacheManager().getSingleFile(
                          widget.platformFileSource.fullNetworkUrl!);
                      await Gal.putVideo(path.path);
                      return " ${S.current.currentDevice}";
                    }
                    return VFileUtils.saveFileToPublicPath(
                      fileAttachment: widget.platformFileSource,
                    );
                  },
                  onSuccess: (url) async {
                    VAppAlert.showSuccessSnackBar(
                      message: widget.successfullyDownloadedInLabel + url,
                      context: context,
                    );
                  },
                  onError: (exception, trace) {},
                );
              },
            ),
      body: SafeArea(
        child: Center(
          child: VConditionalBuilder(
            condition: !isLoading,
            thenBuilder: () => AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: Chewie(
                controller: _chewieController!,
              ),
            ),
            elseBuilder: () => const CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }

  void _initAndPlay() async {
    VideoPlayerController? controller;
    VideoPlayerOptions options =
        VideoPlayerOptions(allowBackgroundPlayback: false);
    if (widget.platformFileSource.isFromPath) {
      controller = VideoPlayerController.file(
        File(widget.platformFileSource.fileLocalPath!),
        videoPlayerOptions: options,
      );
    } else if (widget.platformFileSource.isFromBytes) {
      controller = VideoPlayerController.contentUri(
        Uri.dataFromBytes(widget.platformFileSource.getBytes),
        videoPlayerOptions: options,
      );
    } else if (widget.platformFileSource.isFromAssets) {
      controller = VideoPlayerController.asset(
        widget.platformFileSource.assetsPath!,
        videoPlayerOptions: options,
      );
    } else if (widget.platformFileSource.isFromUrl) {
      final file = await (VPlatforms.isMobile
          ? DefaultCacheManager().getSingleFile(
              widget.platformFileSource.fullNetworkUrl!,
              key: widget.platformFileSource.getCachedUrlKey,
            )
          : null);
      controller = file != null
          ? VideoPlayerController.file(file, videoPlayerOptions: options)
          : VideoPlayerController.networkUrl(
              Uri.parse(widget.platformFileSource.fullNetworkUrl!),
              videoPlayerOptions: options,
            );
    }

    if (controller != null) {
      await controller.initialize();
      setState(() {
        _videoPlayerController = controller;
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: true,
          looping: false,
        );
        isLoading = false;
      });
    }
  }
}
