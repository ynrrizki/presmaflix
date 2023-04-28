import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Film extends Equatable {
  const Film({
    this.id,
    this.title = '',
    this.genre = '',
    this.synopsis = '',
    this.thumbnail = '',
    this.poster = '',
    this.video = '',
    this.rating = 0,
    this.ratings,
    this.reviews,
    this.isRecomended = false,
    this.isLatest = false,
    this.isComingSoon = false,
  });

  final dynamic id;
  final String? title;
  final String? genre;
  final String? synopsis;
  final String? thumbnail;
  final String? poster;
  final dynamic video;
  final num rating;
  final dynamic ratings;
  final dynamic reviews;
  final bool isRecomended;
  final bool isLatest;
  final bool isComingSoon;
  @override
  List<Object?> get props => [genre, synopsis, thumbnail, poster, video];

  factory Film.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Film(
      id: data.id,
      title: data['title'],
      genre: data['genre'],
      synopsis: data['synopsis'],
      thumbnail: data['thumbnail'],
      poster: data['poster'],
      video: data['video'],
      rating: data['rating'],
      ratings: data['ratings'],
      reviews: data['reviews'],
      isRecomended: data['isRecomended'],
      isLatest: data['isLatest'],
      isComingSoon: data['isComingSoon'],
    );
  }

  factory Film.fromReviews(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Film(
      reviews: data['reviews'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'synopsis': synopsis,
      'thumbnail': thumbnail,
      'poster': poster,
      'video': video,
      'rating': rating,
      'reviews': reviews,
      'isRecomended': isRecomended,
      'isLatest': isLatest,
      'isComingSoon': isComingSoon,
    };
  }

  Map<String, dynamic> toReviews(
    dynamic uid,
    String photo,
    String email,
    String name,
    String comment,
  ) {
    return {
      'reviews': {
        uid: {
          'photo': photo,
          'email': email,
          'name': name,
          'comment': comment,
        }
      }
    };
  }

  Map<String, dynamic> toRatings(
    dynamic uid,
    String email,
    String name,
    num rating,
  ) {
    return {
      'ratings': {
        uid: {
          'email': email,
          'name': name,
          'rating': rating,
        }
      }
    };
  }
}
