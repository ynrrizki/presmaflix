class Review {
  final String id;
  final String videoId;
  final String name;
  final String email;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.videoId,
    required this.name,
    required this.email,
    required this.comment,
    required this.createdAt,
  });
}
