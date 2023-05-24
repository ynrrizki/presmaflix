import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';
import 'package:presmaflix/app/models/video.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  late final PodPlayerController videoController;
  List<Video> videos = Video.videos;
  bool isFullScreen = true;

  @override
  void initState() {
    videoController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(videos[0].videoUrl),
    )..initialise();
    videoController.setDoubeTapForwarDuration(10);
    log(videoController.currentVideoPosition.toString());
    videoController.enableFullScreen();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: const IconThemeData(
      //     color: Colors.white,
      //   ),
      // ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: PodVideoPlayer(
              overlayBuilder: (OverLayOptions options) => CustomOverlay(
                options: options,
                controller: videoController,
                video: videos[0],
              ),
              onToggleFullScreen: (isFullScreen) {
                if (isFullScreen) {
                  return SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                } else {
                  return SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                  ]);
                }
              },
              matchFrameAspectRatioToVideo: true,
              matchVideoAspectRatioToFrame: true,
              videoTitle: Padding(
                padding: kIsWeb
                    ? const EdgeInsets.symmetric(vertical: 25, horizontal: 15)
                    : const EdgeInsets.only(left: 15),
                child: Text(
                  videos[0].title.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              controller: videoController,
              videoThumbnail: DecorationImage(
                image: NetworkImage(
                  videos[0].thumbnailUrl.toString(),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 10),
          // Padding(
          //   padding:
          //       EdgeInsets.only(right: MediaQuery.of(context).size.width - 45),
          //   child: Text(videos[0].title.toString()),
          // ),
          // const SizedBox(height: 15),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(videos[0].description.toString(),
          //       style: GoogleFonts.poppins(
          //         fontWeight: FontWeight.w400,
          //         color: Colors.grey,
          //       )),
          // ),
          // const Divider(
          //   thickness: 2,
          //   color: Color.fromARGB(255, 49, 49, 49),
          // ),
        ],
      ),
    );
  }
}

//FIXME Fix Overflow when the screen is landscape
//FIXME Fix back button when the screen is landscape resulting going back to portrait
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
            child: Text(widget.video.title.toString()),
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
                  onDoubleTap: () =>
                      widget.controller.doubleTapVideoBackward(5),
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width / 2,
                  )),
              InkWell(
                  onTap: showOverlay,
                  onDoubleTap: () => widget.controller.doubleTapVideoForward(5),
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width / 2,
                  )),
            ],
          ),
        ],
      ],
    );
  }
}

// class CustomOverlay extends StatefulWidget {
//   final OverLayOptions options;
//   final PodPlayerController controller;
//   final Video video;

//   const CustomOverlay(
//       {super.key,
//       required this.options,
//       required this.controller,
//       required this.video});

//   @override
//   State<CustomOverlay> createState() => _CustomOverlayState();
// }

// class _CustomOverlayState extends State<CustomOverlay> {
//   late bool isOverlayVisible;
//   late Video video;
//   Timer? overlayTimer;

//   @override
//   void initState() {
//     super.initState();
//     isOverlayVisible = widget.options.isOverlayVisible;
//     video = widget.video;
//     _startOverlayTimer();
//   }

//   @override
//   void dispose() {
//     overlayTimer?.cancel();
//     super.dispose();
//   }

//   void _startOverlayTimer() {
//     overlayTimer?.cancel();
//     overlayTimer = Timer(const Duration(seconds: 5), () {
//       setState(() {
//         isOverlayVisible = false;
//       });
//     });
//   }

//   showOverlay() {
//     setState(() {
//       isOverlayVisible = true;
//     });
//     _startOverlayTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         if (isOverlayVisible == true ||
//             widget.options.podVideoState == PodVideoState.paused) ...[
//           Container(
//             color: Colors.black.withOpacity(0.3),
//           ),
//           Row(
//             children: [
//               InkWell(
//                   onTap: () {
//                     isOverlayVisible = false;
//                     overlayTimer?.cancel();
//                   },
//                   onDoubleTap: () =>
//                       widget.controller.doubleTapVideoBackward(5),
//                   child: Container(
//                     color: Colors.transparent,
//                     width: MediaQuery.of(context).size.width / 2,
//                   )),
//               InkWell(
//                   onTap: () {
//                     isOverlayVisible = false;
//                     overlayTimer?.cancel();
//                   },
//                   onDoubleTap: () => widget.controller.doubleTapVideoForward(5),
//                   child: Container(
//                     color: Colors.transparent,
//                     width: MediaQuery.of(context).size.width / 2,
//                   )),
//             ],
//           ),
//           Positioned(
//             bottom: 4,
//             width: MediaQuery.of(context).size.width,
//             child: widget.options.podProgresssBar,
//           ),
//           Positioned(
//             bottom: 12,
//             left: 5,
//             child: Text(
//                 '${widget.options.videoPosition.inHours}:${widget.options.videoPosition.inMinutes}:${widget.options.videoPosition.inSeconds} / ${widget.options.videoDuration.inHours}:${widget.options.videoDuration.inMinutes}:${widget.options.videoDuration.inSeconds}'),
//           ),
//           Positioned(
//               top: 10, left: 10, child: Text(widget.video.title.toString())),
//           if (widget.options.podVideoState == PodVideoState.playing)
//             Positioned(
//               child: Center(
//                 child: IconButton(
//                   iconSize: 48,
//                   onPressed: () {
//                     widget.controller.pause();
//                   },
//                   icon: const Icon(Icons.pause_circle),
//                 ),
//               ),
//             ),
//           if (widget.options.podVideoState == PodVideoState.paused)
//             Positioned(
//               child: Center(
//                 child: IconButton(
//                   iconSize: 48,
//                   onPressed: () {
//                     widget.controller.play();
//                   },
//                   icon: const Icon(Icons.play_circle),
//                 ),
//               ),
//             ),
//         ],
//         if (isOverlayVisible == false) ...[
//           Row(
//             children: [
//               InkWell(
//                   onTap: showOverlay,
//                   onDoubleTap: () =>
//                       widget.controller.doubleTapVideoBackward(5),
//                   child: Container(
//                     color: Colors.transparent,
//                     width: MediaQuery.of(context).size.width / 2,
//                   )),
//               InkWell(
//                   onTap: showOverlay,
//                   onDoubleTap: () => widget.controller.doubleTapVideoForward(5),
//                   child: Container(
//                     color: Colors.transparent,
//                     width: MediaQuery.of(context).size.width / 2,
//                   )),
//             ],
//           ),
//         ],
//       ],
//     );
//   }
// }