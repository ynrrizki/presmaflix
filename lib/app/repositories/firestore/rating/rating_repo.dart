import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:presmaflix/app/models/content/content.dart';
import 'package:presmaflix/app/models/rating/rating.dart';
// import 'package:presmaflix/app/repositories/firestore/repositories.dart';
// import 'package:presmaflix/app/models/content/content.dart';

class RatingRepository {
  final FirebaseFirestore _firebaseFirestore;

  RatingRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<double> getRatingByContent(String id) {
    log('query rating by content', name: 'getRatingByContent');
    return _firebaseFirestore
        .collection('ratings')
        .where('contentId', isEqualTo: id)
        .snapshots()
        .map<double>((snapshot) {
      double totalRating = 0;
      int ratingCount = snapshot.docs.length;

      if (ratingCount > 0) {
        for (var doc in snapshot.docs) {
          totalRating += doc.data()['rating'] ?? 0;
        }
        log((totalRating / ratingCount).toString(), name: 'getRatingByContent');

        return totalRating / ratingCount;
      } else {
        return 0;
      }
    });
  }

  Stream<Rating> getRatingByUser(String userId, String contentId) {
    log('query rating by user', name: 'getRatingByContent');
    return _firebaseFirestore
        .collection('ratings')
        .where('userId', isEqualTo: userId)
        .where('contentId', isEqualTo: contentId)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return Rating.fromSnapshot(querySnapshot.docs.first);
      } else {
        return const Rating(rating: 0.0);
      }
    });
  }

  Future<dynamic> addRating(Rating rating) async {
    if (rating.rating == 0) {
      // Menghapus data jika nilai rating adalah 0
      final docRef = _firebaseFirestore.collection('ratings').doc(rating.id);
      await docRef.delete();
      log('Data Rating ini Dihapus', name: 'addRating');
      return null; // Mengembalikan null karena data telah dihapus
    }

    final docRef = _firebaseFirestore.collection('ratings').doc(rating.id);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      log('Data Rating ini Di Update', name: 'addRating');
      await docRef.update(rating.toDocument());
    } else {
      log('Data Rating ini Di Set', name: 'addRating');
      await docRef.set(rating.toDocument());
    }

    final updatedSnapshot = await docRef.get();
    return Rating.fromSnapshot(updatedSnapshot);
  }
}
