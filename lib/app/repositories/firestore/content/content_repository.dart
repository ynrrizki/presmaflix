import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presmaflix/app/models/content/content.dart';
// import 'package:presmaflix/app/models/video.dart';

class ContentRepository {
  final List<Content> _contents;
  final FirebaseFirestore _firebaseFirestore;
  ContentRepository(
      {List<Content>? contents, FirebaseFirestore? firebaseFirestore})
      : _contents = contents ?? Content.contents,
        _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Content>> getAllContentsArray() async* {
    log('When add getAllContents', name: 'ContentRepository');
    yield _contents;
  }

  Stream<List<Content>> getAllContents() {
    log('When add getAllContents', name: 'ContentRepository');
    return _firebaseFirestore.collection('contents').snapshots().map(
          (snapshot) => snapshot.docs.map(
            (docs) {
              return Content.fromSnapshot(docs);
            },
          ).toList(),
        );
  }
}
