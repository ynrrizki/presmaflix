import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presmaflix/app/models/review/review.dart';
import 'package:presmaflix/app/models/video/video.dart';

class ReviewRepository {
  final FirebaseFirestore _firebaseFirestore;

  ReviewRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Review>> getReviewByVideo(Video video) {
    return _firebaseFirestore
        .collection('reviews')
        .where('videoId', isEqualTo: video.id)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (doc) {
              return Review.fromSnapshot(doc);
            },
          ).toList(),
        );
  }

  Future<dynamic> setReview(Review review) async {
    final docRef = _firebaseFirestore.collection('reviews').doc(review.id);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      log('Data Review ini Di Update', name: 'addReview');
      await docRef.update(review.toDocument());
    } else {
      log('Data Rating ini Di Set', name: 'addReview');
      await docRef.set(review.toDocument());
    }

    final updatedSnapshot = await docRef.get();
    return Review.fromSnapshot(updatedSnapshot);
  }

  Future<void> deleteReview(Review review) async {
    final reviewsCollection = _firebaseFirestore.collection('reviews');

    final querySnapshot = await reviewsCollection.doc(review.id).get();

    final batch = _firebaseFirestore.batch();

    batch.delete(querySnapshot.reference);

    await batch.commit();
  }
}
