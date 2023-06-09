import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String contentId;
  final String? title;
  final String type;
  final String videoUrl;
  final String? thumbnailUrl;
  final String? description;
  final String duration;
  final Timestamp createdAt;

  const Video({
    required this.id,
    required this.contentId,
    this.title,
    required this.type,
    required this.videoUrl,
    this.thumbnailUrl,
    this.description,
    required this.duration,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        contentId,
        title,
        type,
        videoUrl,
        thumbnailUrl,
        description,
        duration,
        createdAt,
      ];

  factory Video.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final id = snapshot.id;
    final data = snapshot.data();
    if (data == null) {
      // Tambahkan log untuk mencatat kesalahan
      throw Exception('Data snapshot is null');
    }
    if (!data.containsKey('contentId') ||
        !data.containsKey('type') ||
        !data.containsKey('videoUrl') ||
        !data.containsKey('duration') ||
        !data.containsKey('createdAt')) {
      // Tambahkan log untuk mencatat kesalahan
      throw Exception('Required fields are missing in data snapshot');
    }
    return Video(
      id: id,
      contentId: data['contentId'],
      title: data['title'] ?? '',
      type: data['type'],
      videoUrl: data['videoUrl'],
      thumbnailUrl: data['thumbnailUrl'],
      description: data['description'],
      duration: data['duration'],
      createdAt: data['createdAt'],
    );
  }

  // 1 - 6
  static List<Video> videos = [
    Video(
      id: '1',
      contentId: '1',
      type: 'full-length',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '2',
      contentId: '2',
      type: 'full-length',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '3',
      contentId: '3',
      type: 'full-length',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '4',
      contentId: '4',
      type: 'full-length',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '5',
      contentId: '5',
      type: 'full-length',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '6',
      contentId: '6',
      type: 'Episodes',
      title: 'Episode 1',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '7',
      contentId: '6',
      type: 'Episodes',
      title: 'Episode 2',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '8',
      contentId: '6',
      type: 'Episodes',
      title: 'Episode 3',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '9',
      contentId: '6',
      type: 'Episodes',
      title: 'Episode 4',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '10',
      contentId: '6',
      type: 'Episodes',
      title: 'Episode 5',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '11',
      contentId: '1',
      title: 'Sipder-Man: No Way Home Trailer',
      type: 'Trailer',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '1m',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '12',
      contentId: '2',
      title: 'Buya Hamka Trailer',
      type: 'Trailer',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '1m',
      createdAt: Timestamp.now(),
    ),
    Video(
      id: '13',
      contentId: '6',
      title: 'Game of Thrones Trailer',
      type: 'Trailer',
      videoUrl: 'https://youtu.be/bqsY1jDkQzk',
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dignissimos eaque odio repudiandae magni cum adipisci doloribus nulla eos perspiciatis expedita, laudantium fuga omnis sed deleniti ratione dolorum ducimus minus cumque?',
      duration: '1m',
      createdAt: Timestamp.now(),
    ),
  ];
}
