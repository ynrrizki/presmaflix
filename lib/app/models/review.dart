import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String videoId;
  final String name;
  final String email;
  final String comment;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.videoId,
    required this.name,
    required this.email,
    required this.comment,
    required this.createdAt,
  });

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
      createdAt: DateTime.now(),
    ),
  ];
}
