import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String videoId;
  final String name;
  final String email;
  final String comment;
  final Timestamp createdAt;

  const Review({
    required this.id,
    required this.videoId,
    required this.name,
    required this.email,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot;
    return Review(
      id: data.id,
      videoId: data['videoId'],
      name: data['name'],
      email: data['email'],
      comment: data['comment'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'videoId': videoId,
      'name': name,
      'email': email,
      'comment': comment,
      'createdAt': Timestamp.now()
    };
  }

  @override
  List<Object?> get props => [
        id,
        videoId,
        name,
        email,
        comment,
        createdAt,
      ];

  static List<Review> reviews = [
    Review(
      id: '1',
      videoId: '1',
      name: 'Yanuar Rizki',
      email: 'yanuarrizki165@gmail.com',
      comment: "Videonya keren banget gilaaa",
      createdAt: Timestamp.now(),
    ),
  ];
}
