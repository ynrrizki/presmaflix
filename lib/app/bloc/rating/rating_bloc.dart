import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:presmaflix/app/bloc/blocs.dart';
import 'package:presmaflix/app/repositories/firestore/rating/rating_repo.dart';
import 'package:presmaflix/app/models/content/content.dart';
// import 'package:presmaflix/app/models/rating/rating.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, double> {
  final RatingRepository ratingRepository;
  StreamSubscription? _ratingSubscription;

  RatingBloc({required this.ratingRepository}) : super(0.0) {
    on<LoadRating>(_onLoadRating);
    on<UpdateRating>(_onUpdateRating);
  }

  void _onLoadRating(LoadRating event, Emitter<double> emit) {
    _ratingSubscription?.cancel();
    _ratingSubscription =
        ratingRepository.getRatingByContent(event.contentId).listen((rating) {
      log(rating.toString(), name: 'onLoadRating');
      return add(UpdateRating(rating));
    });
  }

  void _onUpdateRating(UpdateRating event, Emitter<double> emit) {
    // emit(RatingLoaded(rating: event.rating));
    emit(event.rating);
  }

  @override
  Future<void> close() async {
    _ratingSubscription?.cancel();
    super.close;
  }
}
