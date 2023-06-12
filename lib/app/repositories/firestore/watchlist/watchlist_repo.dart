import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presmaflix/app/models/watchlist/watchlist.dart';

class WatchlistRepository {
  // final List<Content> _contents;
  final FirebaseFirestore _firebaseFirestore;
  WatchlistRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = FirebaseFirestore.instance;

  // Stream<List<Watchlist>> getAllContentsArray() async* {
  //   log('When add getAllWatchlists', name: 'ContentRepository');
  //   yield _contents;
  // }

  Stream<List<Watchlist>> getAllWatchlists() {
    log('When add getAllWatchlists', name: 'WatchlistRepository');
    return _firebaseFirestore.collection('watchlist').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (docs) => Watchlist.fromSnapshot(docs),
              )
              .toList(),
        );
  }
}
