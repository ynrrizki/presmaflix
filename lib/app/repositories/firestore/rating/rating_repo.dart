import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
}
