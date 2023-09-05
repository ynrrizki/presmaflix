part of 'rating_bloc.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object> get props => [];
}

class LoadRating extends RatingEvent {
  final String contentId;
  const LoadRating(this.contentId);

  @override
  List<Object> get props => [contentId];
}

class LoadRatingByUser extends RatingEvent {
  final String contentId;
  final String userId;
  const LoadRatingByUser(this.userId, this.contentId);

  @override
  List<Object> get props => [userId, contentId];
}

class UpdateRating extends RatingEvent {
  final double rating;
  const UpdateRating(this.rating);

  @override
  List<Object> get props => [rating];
}

class UpdateRatingByUser extends RatingEvent {
  final Rating rating;
  const UpdateRatingByUser(this.rating);

  @override
  List<Object> get props => [rating];
}

class AddRating extends RatingEvent {
  final Rating rating;
  const AddRating({
    required this.rating,
  });

  @override
  List<Object> get props => [rating];
}
