import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';
import 'package:presmaflix/app/bloc/app/app_bloc.dart';
import 'package:presmaflix/app/bloc/blocs.dart';
import 'package:presmaflix/app/bloc/review/review_bloc.dart';
import 'package:presmaflix/app/models/review/review.dart';
import 'package:presmaflix/app/models/video/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:presmaflix/config/themes.dart';
// import 'package:presmaflix/ui/widgets/widgets.dart';
// import 'package:presmaflix/config/themes.dart';

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
  bool isEditing = false;
  String commentId = '';

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

  void toggleEditing() {
    setState(() {
      isEditing = true;
    });
  }

  void setCommentId(String id) {
    setState(() {
      commentId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      body: ListView(
        children: [
          ClipRect(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: PodVideoPlayer(
                alwaysShowProgressBar: false,
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
          Column(
            children: [
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        widget.video.title.toString(),
                        softWrap: true,
                      ),
                    ),
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
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text('Comments'),
                  const SizedBox(height: 10),
                  ListTile(
                    onTap: () => _commentColumn(context),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        user.avatar ??
                            'https://ui-avatars.com/api/?name=${user.name}',
                      ),
                    ),
                    title: TextField(
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        hintText: 'Add a comment',
                        enabled: false,
                        constraints: BoxConstraints(
                          maxHeight: 35,
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldComment(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 8,
        left: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                user.avatar ?? 'https://ui-avatars.com/api/?name=${user.name}',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(23, 70, 70, 70).withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: TextField(
                controller: commentController,
                autocorrect: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                    left: 13,
                    right: 13,
                  ),
                  hintText: 'Tambahkan Komentar...',
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      if (commentController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Komentar Tidak Boleh Kosong',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      if (isEditing == false) {
                        FirebaseFirestore.instance.collection('reviews').add({
                          'videoId': widget.video.id,
                          'name': await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get()
                              .then((value) => value.data()!['name']),
                          'email': FirebaseAuth.instance.currentUser!.email,
                          'comment': commentController.text,
                          'createdAt': DateTime.now(),
                        }).then((value) => commentController.clear());
                      } else {
                        FirebaseFirestore.instance
                            .collection('reviews')
                            .doc(commentId)
                            .update({
                              'comment': commentController.text,
                            })
                            .then((value) => commentController.clear())
                            .then(
                              (value) => setState(() {
                                isEditing = false;
                              }),
                            );
                      }
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

  Future _commentColumn(context) {
    return showModalBottomSheet(
      context: context,
      elevation: 0,
      isDismissible: false,
      showDragHandle: true,
      useSafeArea: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      constraints: const BoxConstraints(
        maxHeight: 580,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Comments',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                  height: 2,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: BlocBuilder<ReviewBloc, ReviewState>(
                  bloc: context.read<ReviewBloc>()
                    ..add(LoadReviewByVideo(video: widget.video)),
                  builder: (context, state) {
                    if (state is ReviewLoaded) {
                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverList.separated(
                            separatorBuilder: (context, index) => const Divider(
                              thickness: 2,
                              color: Color.fromARGB(255, 49, 49, 49),
                            ),
                            itemCount: state.reviews.length,
                            itemBuilder: (context, index) {
                              final review = state.reviews[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: commentWidget(
                                  review,
                                  context,
                                  commentController,
                                  toggleEditing,
                                  review.id,
                                  setCommentId,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Not Yet Comment',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 20),
            //     child: StreamBuilder(
            //       stream: FirebaseFirestore.instance
            //           .collection('reviews')
            //           .where('videoId', isEqualTo: widget.video.id)
            //           .orderBy('createdAt', descending: true)
            //           .snapshots(),
            //       builder: (context, snapshot) {
            //         if (snapshot.data!.docs.isNotEmpty) {
            //           return CustomScrollView(
            //             shrinkWrap: true,
            //             slivers: [
            //               SliverList.separated(
            //                 separatorBuilder: (context, index) => const Divider(
            //                   thickness: 2,
            //                   color: Color.fromARGB(255, 49, 49, 49),
            //                 ),
            //                 itemCount: snapshot.data?.docs.length ?? 0,
            //                 itemBuilder: (context, index) {
            //                   final doc = snapshot.data!.docs[index];
            //                   return Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                       horizontal: 15,
            //                     ),
            //                     child: commentWidget(
            //                       doc,
            //                       context,
            //                       commentController,
            //                       toggleEditing,
            //                       doc.id,
            //                       setCommentId,
            //                     ),
            //                   );
            //                 },
            //               ),
            //             ],
            //           );
            //         } else {
            //           return Center(
            //             child: Text(
            //               'Not Yet Comment',
            //               style: GoogleFonts.poppins(
            //                 fontSize: 18,
            //               ),
            //             ),
            //           );
            //         }
            //       },
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _fieldComment(context),
            ),
          ],
        );
      },
    );
  }
}

Widget commentWidget(
  Review review,
  BuildContext context,
  TextEditingController commentController,
  VoidCallback toggleEditing,
  String commentId,
  Function(String) updateCommentId,
) {
  return Card(
    color: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: BlocBuilder<UserBloc, UserState>(
        bloc: context.read<UserBloc>()
          ..add(
            LoadUserByEmail(email: review.email),
          ),
        builder: (context, state) {
          if (state is UserByIdLoaded) {
            return CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                state.user.avatar!,
              ),
              radius: 20,
            );
          }
          return CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              'https://ui-avatars.com/api/?name=${review.name}',
            ),
            radius: 20,
          );
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            review.comment,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.white,
            ),
          )
        ],
      ),
      trailing: FirebaseAuth.instance.currentUser!.email == review.email
          ? IconButton(
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
                                    .collection('reviews')
                                    .doc(review.id)
                                    .get()
                                    .then((value) {
                                      updateCommentId(review.id);
                                      commentController.text =
                                          value.data()!['comment'];
                                    })
                                    .then((value) => toggleEditing())
                                    .then(
                                        (value) => Navigator.of(context).pop());
                              },
                            ),
                            const Padding(padding: EdgeInsets.all(8)),
                            GestureDetector(
                              child: const Text('Hapus'),
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('reviews')
                                    .doc(review.id)
                                    .delete()
                                    .then((value) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Komentar Berhasil Dihapus",
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        ))
                                    .then(
                                        (value) => Navigator.of(context).pop());
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
          : null,
    ),
  );
}
// Widget commentWidget(
//   DocumentSnapshot docs,
//   BuildContext context,
//   TextEditingController commentController,
//   VoidCallback toggleEditing,
//   String commentId,
//   Function(String) updateCommentId,
// ) {
//   return Card(
//     color: Colors.transparent,
//     shadowColor: Colors.transparent,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//     child: ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 0),
//       leading: CircleAvatar(
//         backgroundImage:
//             NetworkImage('https://ui-avatars.com/api/?name=${docs["name"]}'),
//         radius: 20,
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             docs['name'],
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.w600,
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ),
//           Text(
//             docs['comment'],
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.w400,
//               fontSize: 14,
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//       trailing: FirebaseAuth.instance.currentUser!.email == docs['email']
//           ? IconButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text('Options'),
//                       content: SingleChildScrollView(
//                         child: ListBody(
//                           children: <Widget>[
//                             GestureDetector(
//                               child: const Text('Edit'),
//                               onTap: () {
//                                 FirebaseFirestore.instance
//                                     .collection('reviews')
//                                     .doc(docs.id)
//                                     .get()
//                                     .then((value) {
//                                       updateCommentId(docs.id);
//                                       commentController.text =
//                                           value.data()!['comment'];
//                                     })
//                                     .then((value) => toggleEditing())
//                                     .then(
//                                         (value) => Navigator.of(context).pop());
//                               },
//                             ),
//                             const Padding(padding: EdgeInsets.all(8)),
//                             GestureDetector(
//                               child: const Text('Hapus'),
//                               onTap: () {
//                                 FirebaseFirestore.instance
//                                     .collection('reviews')
//                                     .doc(docs.id)
//                                     .delete()
//                                     .then((value) =>
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             content: Text(
//                                               "Komentar Berhasil Dihapus",
//                                               style: GoogleFonts.montserrat(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             backgroundColor: Colors.red,
//                                           ),
//                                         ))
//                                     .then(
//                                         (value) => Navigator.of(context).pop());
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//               icon: const Icon(Icons.more_vert),
//             )
//           : null,
//     ),
//   );
// }
