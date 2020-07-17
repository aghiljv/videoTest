import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String assetPath;
//  final File localFile;
  final bool showControls;
  final bool autoPlay;
  final bool looping;
  final bool showPlaceholder;
  final Function onInitialized;

  VideoPlayerWidget({
    @required this.assetPath,
//    @required this.localFile,
    this.showControls = true,
    this.autoPlay = true,
    this.looping = true,
    this.showPlaceholder = false,
    this.onInitialized,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = widget.assetPath != null
        ? VideoPlayerController.asset(widget.assetPath)
        : null;
    _videoPlayerController.setVolume(0.0);
    _videoPlayerController?.initialize()?.then((_) {
      chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        showControls: widget.showControls,
      );
      setState(() {});
      if (widget.onInitialized != null) {
        widget.onInitialized();
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
    print("Video Player - Disposed");
  }

  @override
  Widget build(BuildContext context) {
    return chewieController == null
        ? widget.showPlaceholder
            ? Container(
                constraints: BoxConstraints(minHeight: 100),
                child: Center(
                    child: SizedBox(
                        child: CircularProgressIndicator(strokeWidth: 2),
                        width: 20,
                        height: 20)),
              )
            : Container()
        : Chewie(controller: chewieController);
  }
}
