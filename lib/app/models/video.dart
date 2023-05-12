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

  // 1 - 6
  static List<Video> videos = [
    Video(
      id: '1',
      mediaId: '1',
      type: 'movie',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '2',
      mediaId: '2',
      type: 'movie',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '3',
      mediaId: '3',
      type: 'movie',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '4',
      mediaId: '4',
      type: 'movie',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '5',
      mediaId: '5',
      type: 'movie',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '6',
      mediaId: '6',
      type: 'tv-global',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '7',
      mediaId: '6',
      type: 'tv-global',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '8',
      mediaId: '6',
      type: 'tv-global',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '9',
      mediaId: '6',
      type: 'tv-global',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '10',
      mediaId: '6',
      type: 'tv-global',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
  ];
}
