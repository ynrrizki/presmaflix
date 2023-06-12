import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final String id;
  final String contentId;
  final String name;
  final String email;
  final double rating;

  const Rating({
    required this.id,
    required this.contentId,
    required this.name,
    required this.email,
    required this.rating,
  });

  factory Rating.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Rating(
      id: data.id,
      contentId: data['contentId'],
      name: data['name'],
      email: data['email'],
      rating: data['rating'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'contentId': contentId,
      'name': email,
      'email': name,
      'rating': rating,
    };
  }

  @override
  List<Object?> get props => [id, contentId, name, email, rating];

  static List<Rating> ratings = [
    const Rating(
      id: '1',
      contentId: '1',
      name: 'Yanuar Rizki',
      email: 'yanuarrizki165@gmail.com',
      rating: 1.5,
    ),
  ];
}
