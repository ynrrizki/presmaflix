import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final String? id;
  final String? contentId;
  final String? userId;
  final String? email;
  final double? rating;

  const Rating({
    this.id,
    this.contentId,
    this.userId,
    this.email,
    this.rating,
  });

  factory Rating.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Rating(
      id: data.id,
      contentId: data['contentId'],
      userId: data['userId'],
      email: data['email'],
      rating: data['rating'],
    );
  }

  Rating copyWith({
    String? id,
    String? contentId,
    String? userId,
    String? email,
    double? rating,
  }) {
    return Rating(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toRating(String contentId, String email, double rating) {
    return {
      'contentId': contentId,
      'userId': userId,
      'email': email,
      'rating': rating,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'contentId': contentId,
      'userId': userId,
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
      userId: '1',
      email: 'yanuarrizki165@gmail.com',
      rating: 1.5,
    ),
  ];
}
