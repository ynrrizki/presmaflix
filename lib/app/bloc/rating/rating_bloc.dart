import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:presmaflix/app/bloc/blocs.dart';
import 'package:presmaflix/app/repositories/firestore/rating/rating_repo.dart';
// import 'package:presmaflix/app/models/content/content.dart';
import 'package:presmaflix/app/models/rating/rating.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RatingRepository ratingRepository;
  StreamSubscription? _ratingSubscription;

  RatingBloc({required this.ratingRepository}) : super(RatingInitial()) {
    on<LoadRating>(_onLoadRating);
    on<UpdateRating>(_onUpdateRating);
    on<AddRating>((event, emit) async {
      await ratingRepository.addRating(event.rating);
    });
  }

  void _onLoadRating(LoadRating event, Emitter<RatingState> emit) {
    _ratingSubscription?.cancel();
    _ratingSubscription =
        ratingRepository.getRatingByContent(event.contentId).listen((rating) {
      log(rating.toString(), name: 'onLoadRating');
      return add(UpdateRating(rating));
    });
  }

  void _onUpdateRating(UpdateRating event, Emitter<RatingState> emit) {
    emit(RatingLoaded(rating: event.rating));
    // emit(event);
  }

  @override
  Future<void> close() async {
    _ratingSubscription?.cancel();
    super.close;
  }
}
