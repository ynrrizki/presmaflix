import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/presentation/bloc/watchlist/watchlist_bloc.dart';
// import 'package:presmaflix/app/models/content/content.dart';
import 'package:presmaflix/data/repositories/firestore/watchlist/watchlist_repo.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final WatchlistRepository _watchlistRepository;
  final WatchlistBloc _watchlistBloc;
  WatchlistCubit(this._watchlistRepository, this._watchlistBloc)
      : super(WatchlistState.initial());

  Future<void> isWatchlistExists(
      {required String contentId, required String userId}) async {
    if (state.status == WatchlistStatus.submitting) return;
    emit(state.copyWith(status: WatchlistStatus.submitting));
    try {
      bool isWatchlistExists = await _watchlistRepository.isWatchlistExists(
          contentId: contentId, userId: userId);
      emit(state.copyWith(status: WatchlistStatus.success));
      log('$isWatchlistExists', name: 'WatchlistCubit');
      if (!isWatchlistExists) {
        emit(state.copyWith(status: WatchlistStatus.notExists));
        _watchlistBloc.add(AddWatchlist(contentId: contentId, userId: userId));
      } else {
        emit(state.copyWith(status: WatchlistStatus.exists));
      }
    } on Exception {
      emit(state.copyWith(status: WatchlistStatus.error));
    }
  }
}
