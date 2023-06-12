import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presmaflix/app/models/watchlist/watchlist.dart';

class WatchlistRepository {
  // final List<Content> _contents;
  final FirebaseFirestore _firebaseFirestore;
  WatchlistRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Watchlist>> getAllWatchlists() {
    log('When add getAllWatchlists', name: 'WatchlistRepository');
    return _firebaseFirestore.collection('watchlists').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (docs) => Watchlist.fromSnapshot(docs),
              )
              .toList(),
        );
  }

  Future<void> addWatchlist(
      {required String contentId, required String userId}) {
    final watchlistData = {
      'contentId': contentId,
      'userId': userId,
    };
    return _firebaseFirestore.collection('watchlists').add(watchlistData);
  }

  Future<void> deleteWatchlist(String watchlistId) {
    return _firebaseFirestore
        .collection('watchlists')
        .doc(watchlistId)
        .delete();
  }

  Future<void> deleteWatchlistByContentId(String contentId) async {
    final watchlistsCollection = _firebaseFirestore.collection('watchlists');

    final querySnapshot = await watchlistsCollection
        .where('contentId', isEqualTo: contentId)
        .get();

    final batch = _firebaseFirestore.batch();

    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Stream<bool> isStreamWatchlistExists(
      {required String contentId, required String userId}) {
    return _firebaseFirestore
        .collection('watchlists')
        .where('contentId', isEqualTo: contentId)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }

  Future<bool> isWatchlistExists(
      {required String contentId, required String userId}) async {
    final querySnapshot = await _firebaseFirestore
        .collection('watchlists')
        .where('contentId', isEqualTo: contentId)
        .where('userId', isEqualTo: userId)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}
