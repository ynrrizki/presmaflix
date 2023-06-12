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

class UpdateRating extends RatingEvent {
  final double rating;
  const UpdateRating(this.rating);

  @override
  List<Object> get props => [rating];
}
