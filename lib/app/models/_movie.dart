import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie({
    this.id = '',
    this.title = '',
    this.genre = '',
    this.synopsis = '',
    this.thumbnail = '',
    this.poster = '',
    this.video = '',
    this.rating = 0,
    this.ratings,
    this.reviews,
    this.isShowBanner = false,
    this.releaseAt,
  });

  final String id;
  final String title;
  final String genre;
  final String synopsis;
  final String thumbnail;
  final String poster;
  final String video;
  final num rating;
  final dynamic ratings;
  final dynamic reviews;
  final bool isShowBanner;
  final dynamic releaseAt;

  @override
  List<Object?> get props => [genre, synopsis, thumbnail, poster, video];

  factory Movie.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Movie(
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
        isShowBanner: data['isShowBanner'],
        releaseAt: data['releaseAt']);
  }

  factory Movie.fromReviews(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Movie(
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
      'isShowBanner': isShowBanner,
      'releaseAt': releaseAt
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
