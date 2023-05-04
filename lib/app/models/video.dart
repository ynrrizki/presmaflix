class Video {
  final String id;
  final String mediaId;
  final String type;
  final String video;
  final String? thumbnailUrl;
  final String? description;
  final String duration;
  final DateTime createdAt;

  const Video({
    required this.id,
    required this.mediaId,
    required this.type,
    required this.video,
    this.thumbnailUrl,
    this.description,
    required this.duration,
    required this.createdAt,
  });

  // 1 - 5
  static List<Video> videos = [
    Video(
      id: '1',
      mediaId: '1',
      type: 'movie',
      video: '',
      thumbnailUrl: '',
      description: '',
      duration: '',
      createdAt: DateTime.now(),
    ),
  ];
}
