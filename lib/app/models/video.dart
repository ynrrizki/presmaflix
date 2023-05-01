class Video {
  final String id;
  final String mediaId;
  final String type;
  final String video;
  final String? thumbnailUrl;
  final String? synopsis;
  final String duration;
  final DateTime createdAt;

  Video({
    required this.id,
    required this.mediaId,
    required this.type,
    required this.video,
    this.thumbnailUrl,
    this.synopsis,
    required this.duration,
    required this.createdAt,
  });
}
