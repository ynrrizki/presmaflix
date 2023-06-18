import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/models/review/review.dart';
import 'package:presmaflix/app/models/video/video.dart';
import 'package:presmaflix/app/repositories/firestore/review/review_repo.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository _reviewRepository;
  StreamSubscription? _reviewSubscription;
  ReviewBloc({required ReviewRepository reviewRepository})
      : _reviewRepository = reviewRepository,
        super(ReviewInitial()) {
    on<LoadReviewByVideo>(_onLoadReviewByVideo);
    on<UpdateReview>(_onUpdateReview);
  }

  void _onLoadReviewByVideo(
    LoadReviewByVideo event,
    Emitter<ReviewState> emit,
  ) {
    _reviewSubscription?.cancel();
    _reviewSubscription =
        _reviewRepository.getReviewByVideo(event.video).listen((review) {
      return add(UpdateReview(reviews: review));
    });
  }

  void _onUpdateReview(
    UpdateReview event,
    Emitter<ReviewState> emit,
  ) {
    emit(ReviewLoading());
    emit(ReviewLoaded(reviews: event.reviews));
  }

  @override
  Future<void> close() {
    _reviewSubscription?.cancel();
    return super.close();
  }
}
