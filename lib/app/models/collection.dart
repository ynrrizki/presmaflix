import './content.dart';
import './media.dart';
import './video.dart';
import './review.dart';

class Collection {
  final List<Content> contents;
  final List<Media> media;
  final List<Video> videos;
  final List<Review> reviews;

  Collection({
    required this.contents,
    required this.media,
    required this.videos,
    required this.reviews,
  });
}
