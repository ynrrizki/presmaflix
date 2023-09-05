import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presmaflix/data/models/content/content.dart';
import 'package:presmaflix/data/models/video/video.dart';

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

  Stream<List<Video>> getAllVideos() {
    log('When add getAllVideos', name: 'VideoRepository');
    return _firebaseFirestore.collection('videos').snapshots().map((snapshot) =>
        snapshot.docs.map((docs) => Video.fromSnapshot(docs)).toList());
  }

  Stream<List<Video>> getAllVideosByContent(Content content) {
    log('When add getAllVideosByContent', name: 'VideoRepository');
    String contentId = content.id.trim();
    return _firebaseFirestore
        .collection('videos')
        .where('contentId', isEqualTo: contentId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((docs) => Video.fromSnapshot(docs)).toList(),
        );
  }
}
