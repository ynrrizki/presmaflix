import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';
import 'package:presmaflix/app/models/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContentVideoPage extends StatefulWidget {
  const ContentVideoPage({super.key, required this.video});

  final Video video;

  @override
  State<ContentVideoPage> createState() => ContentVideoPageState();
}

class ContentVideoPageState extends State<ContentVideoPage> {
  TextEditingController commentController = TextEditingController();
  late final PodPlayerController videoController;
  List<Video> videos = Video.videos;
  bool isFullScreen = true;

  @override
  void initState() {
    videoController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.video.videoUrl),
    )..initialise();
    videoController.setDoubeTapForwarDuration(10);
    log(videoController.currentVideoPosition.toString());
    videoController.enableFullScreen();
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
      body: Column(
        children: [
          ClipRect(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: PodVideoPlayer(
                alwaysShowProgressBar: false,
                overlayBuilder: (OverLayOptions options) => CustomOverlay(
                  options: options,
                  controller: videoController,
                  video: widget.video,
                ),
                controller: videoController,
                videoThumbnail: DecorationImage(
                  image: NetworkImage(
                    widget.video.thumbnailUrl.toString(),
                  ),
                ),
                matchFrameAspectRatioToVideo: true,
                matchVideoAspectRatioToFrame: true,
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(widget.video.title.toString()),
                            ),
                            IconButton.filled(
                              onPressed: () {},
                              icon: const Icon(Icons.share),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.video.description.toString(),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Color.fromARGB(255, 49, 49, 49),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('review')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return SliverList.separated(
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 2,
                          color: Color.fromARGB(255, 49, 49, 49),
                        ),
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];
                          return commentWidget(doc, context, commentController);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  hintText: 'Tambahkan Komentar...',
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('review').add({
                        'videoId': widget.video.id,
                        'name': 'Yanuar Rizki',
                        'email': 'yanuarrizki165@gmail.com',
                        'comment': commentController.text,
                        'createdAt': DateTime.now(),
                      }).then((value) => commentController.clear());
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget commentWidget(DocumentSnapshot docs, BuildContext context,
    TextEditingController commentController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(14.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                docs['name'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                docs['comment'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (FirebaseAuth.instance.currentUser!.email == docs['email'])
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Options'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            GestureDetector(
                              child: const Text('Edit'),
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('review')
                                    .get()
                                    .then((value) => commentController.text =
                                        value.docs[0]['comment'].toString());
                              },
                            ),
                            const Padding(padding: EdgeInsets.all(8)),
                            GestureDetector(
                              child: const Text('Hapus'),
                              onTap: () {
                                // Handle option 2
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.more_vert),
            )
        ],
      ),
    ),
  );
}

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
          const Center(
            child: CircularProgressIndicator(),
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
