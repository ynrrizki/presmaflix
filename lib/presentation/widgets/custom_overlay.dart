import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:presmaflix/data/models/video/video.dart';
import 'package:presmaflix/presentation/config/themes_config.dart';

class CustomOverlay extends StatefulWidget {
  final OverLayOptions options;
  final PodPlayerController controller;
  final Video video;

  const CustomOverlay({
    Key? key,
    required this.options,
    required this.controller,
    required this.video,
  }) : super(key: key);

  @override
  State<CustomOverlay> createState() => _CustomOverlayState();
}

class _CustomOverlayState extends State<CustomOverlay> {
  late bool isOverlayVisible;
  late Video video;
  Timer? overlayTimer;

  @override
  void initState() {
    super.initState();
    isOverlayVisible = widget.options.isOverlayVisible;
    video = widget.video;
    _startOverlayTimer();
  }

  @override
  void dispose() {
    overlayTimer?.cancel();
    super.dispose();
  }

  void _startOverlayTimer() {
    overlayTimer?.cancel();
    overlayTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        isOverlayVisible = false;
      });
    });
  }

  void showOverlay() {
    setState(() {
      isOverlayVisible = true;
    });
    _startOverlayTimer();
  }

  Widget buildOverlayRow() {
    return Stack(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isOverlayVisible = false;
                });
                overlayTimer?.cancel();
              },
              onDoubleTap: () => widget.controller.doubleTapVideoBackward(5),
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isOverlayVisible = false;
                });
                overlayTimer?.cancel();
              },
              onDoubleTap: () => widget.controller.doubleTapVideoForward(5),
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPlayingOverlay() {
    return Positioned(
      child: Center(
        child: IconButton(
          iconSize: 48,
          onPressed: () {
            widget.controller.pause();
          },
          icon: const Icon(Icons.pause_circle),
        ),
      ),
    );
  }

  Widget buildPausedOverlay() {
    return Positioned(
      child: Center(
        child: IconButton(
          iconSize: 48,
          onPressed: () {
            widget.controller.play();
          },
          icon: const Icon(Icons.play_circle),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.options.podVideoState == PodVideoState.loading) ...[
          Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          ),
        ],
        if (isOverlayVisible ||
            widget.options.podVideoState == PodVideoState.paused) ...[
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          buildOverlayRow(),
          Positioned(
            bottom: 4,
            width: MediaQuery.of(context).size.width,
            child: widget.options.podProgresssBar,
          ),
          Positioned(
            bottom: 12,
            left: 5,
            child: Text(
              '${widget.options.videoPosition.inHours}:${widget.options.videoPosition.inMinutes}:${widget.options.videoPosition.inSeconds} / ${widget.options.videoDuration.inHours}:${widget.options.videoDuration.inMinutes}:${widget.options.videoDuration.inSeconds}',
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              widget.video.title.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.options.podVideoState == PodVideoState.playing)
            buildPlayingOverlay(),
          if (widget.options.podVideoState == PodVideoState.paused)
            buildPausedOverlay(),
        ],
        if (!isOverlayVisible) ...[
          Row(
            children: [
              InkWell(
                onTap: showOverlay,
                onDoubleTap: () => widget.controller.doubleTapVideoBackward(5),
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
              InkWell(
                onTap: showOverlay,
                onDoubleTap: () => widget.controller.doubleTapVideoForward(5),
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
