part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class LoadReviewByVideo extends ReviewEvent {
  final Video video;

  const LoadReviewByVideo({required this.video});

  @override
  List<Object> get props => [video];
}

class UpdateReview extends ReviewEvent {
  final List<Review> reviews;
  const UpdateReview({this.reviews = const <Review>[]});

  @override
  List<Object> get props => [reviews];
}

class SetReviewByVideo extends ReviewEvent {}

class DeleteReviewByVideo extends ReviewEvent {}
