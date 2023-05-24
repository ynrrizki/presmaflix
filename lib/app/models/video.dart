import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String mediaId;
  final String? title;
  final String type;
  final String video;
  final String? thumbnailUrl;
  final String? description;
  final String duration;
  final DateTime createdAt;

  const Video({
    required this.id,
    required this.mediaId,
    this.title,
    required this.type,
    required this.video,
    this.thumbnailUrl,
    this.description,
    required this.duration,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        mediaId,
        title,
        type,
        video,
        thumbnailUrl,
        description,
        duration,
        createdAt,
      ];

  // 1 - 6
  static List<Video> videos = [
    Video(
      id: '1',
      mediaId: '1',
      type: 'full-length',
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
      type: 'full-length',
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
      type: 'full-length',
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
      type: 'full-length',
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
      type: 'full-length',
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
      type: 'Episodes',
      title: 'Episode 1',
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
      type: 'Episodes',
      title: 'Episode 2',
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
      type: 'Episodes',
      title: 'Episode 3',
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
      type: 'Episodes',
      title: 'Episode 4',
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
      type: 'Episodes',
      title: 'Episode 5',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '11',
      mediaId: '1',
      title: 'Sipder-Man: No Way Home Trailer',
      type: 'Trailer',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '1m',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '12',
      mediaId: '2',
      title: 'Buya Hamka Trailer',
      type: 'Trailer',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '1m',
      createdAt: DateTime.now(),
    ),
    Video(
      id: '13',
      mediaId: '6',
      title: 'Game of Thrones Trailer',
      type: 'Trailer',
      video: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '1m',
      createdAt: DateTime.now(),
    ),
  ];
}
