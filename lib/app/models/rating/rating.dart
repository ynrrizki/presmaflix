import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final String id;
  final String contentId;
  final String email;
  final double rating;

  const Rating({
    required this.id,
    required this.contentId,
    required this.email,
    required this.rating,
  });

  factory Rating.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Rating(
      id: data.id,
      contentId: data['contentId'],
      email: data['email'],
      rating: data['rating'],
    );
  }

  Map<String, dynamic> toRating(String contentId, String email, double rating) {
    return {
      'id': id,
      'contentId': contentId,
      'email': email,
      'rating': rating,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'contentId': contentId,
      'email': email,
      'rating': rating,
    };
  }

  @override
  List<Object?> get props => [id, contentId, email, rating];

  static List<Rating> ratings = [
    const Rating(
      id: '1',
      contentId: '1',
      email: 'yanuarrizki165@gmail.com',
      rating: 1.5,
    ),
  ];
}
