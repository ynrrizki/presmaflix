part of 'rating_bloc.dart';

abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoaded extends RatingState {
  final double rating;

  const RatingLoaded({required this.rating});

  @override
  List<Object> get props => [rating];
}

class RatingByUserLoaded extends RatingState {
  final Rating rating;

  const RatingByUserLoaded({required this.rating});

  @override
  List<Object> get props => [rating];
}

class RatingByUserInitial extends RatingState {}
