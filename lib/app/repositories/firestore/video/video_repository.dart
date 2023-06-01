import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/app/models/video.dart';

class VideoRepository {
  final List<Video> _videos;
  final FirebaseFirestore _firebaseFirestore;
  VideoRepository({List<Video>? videos, FirebaseFirestore? firebaseFirestore})
      : _videos = videos ?? Video.videos,
        _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Video>> getAllVideosArray() async* {
    log('When add getAllVideos', name: 'VideoRepository');
    yield _videos;
  }

  Stream<List<Video>> getAllVideosByContent(Content content) {
    log('When add getAllVideosByContent', name: 'VideoRepository');
    // _firebaseFirestore.collection('contents').snapshots().listen((event) {
    //   log('When add getAllContents', name: 'ContentRepository');
    //   return log(event.docs.map((e) => e.data()).toList().toString());
    // });
    return _firebaseFirestore
        .collection('videos')
        .where('contentId', isEqualTo: content.id)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (docs) => Video.fromSnapshot(docs),
              )
              .toList(),
        );
  }
}
