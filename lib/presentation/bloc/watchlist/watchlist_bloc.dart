import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/data/repositories/firestore/watchlist/watchlist_repo.dart';
import 'package:presmaflix/data/models/watchlist/watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepository _watchlistRepository;
  StreamSubscription? _watchlistSubscription;
  StreamSubscription? _isWatchlistSubscription;

  WatchlistBloc({required WatchlistRepository watchlistRepository})
      : _watchlistRepository = watchlistRepository,
        super(WatchlistLoading()) {
    // Watchlists
    on<LoadWatchlists>(_onLoadWatchlists);
    on<UpdateWatchlists>(_onUpdateWatchlists);

    // isWatchlistExists
    on<LoadIsWatchlistExists>(_onLoadIsWatchlistExists);
    on<UpdateIsWatchlistExists>(_onUpdateIsWatchlistExists);

    // Add and Delete
    on<AddWatchlist>(_onAddWatchlist);
    on<DeleteWatchlist>(_onDeleteWatchlist);
    on<DeleteWatchlistByContentId>(_onDeleteWatchlistByContentId);
  }

  void _onLoadWatchlists(
    LoadWatchlists event,
    Emitter<WatchlistState> emit,
  ) {
    log('when add LoadWatchlists', name: 'WatchlistBloc');
    _watchlistSubscription?.cancel();
    _watchlistSubscription = _watchlistRepository.getAllWatchlists().listen(
      (watchlists) {
        log('when add UpdateWatchlists', name: 'WatchlistBloc');
        return add(
          UpdateWatchlists(watchlists),
        );
      },
    );
  }

  void _onUpdateWatchlists(
    UpdateWatchlists event,
    Emitter<WatchlistState> emit,
  ) {
    emit(WatchlistLoading());
    emit(WatchlistLoaded(watchlists: event.watchlists));
  }

  void _onLoadIsWatchlistExists(
    LoadIsWatchlistExists event,
    Emitter<WatchlistState> emit,
  ) {
    log('when add LoadIsWatchlistExists', name: 'WatchlistBloc');
    _isWatchlistSubscription?.cancel();
    _isWatchlistSubscription = _watchlistRepository
        .isStreamWatchlistExists(
            contentId: event.contentId, userId: event.userId)
        .listen(
      (isExists) {
        log('when add UpdateIsWatchlistExists', name: 'WatchlistBloc');
        return add(
          UpdateIsWatchlistExists(isExists: isExists),
        );
      },
    );
  }

  void _onUpdateIsWatchlistExists(
    UpdateIsWatchlistExists event,
    Emitter<WatchlistState> emit,
  ) {
    emit(WatchlistLoading());
    emit(IsWatchlistExistsLoaded(isExists: event.isExists));
  }

  void _onAddWatchlist(
    AddWatchlist event,
    Emitter<WatchlistState> emit,
  ) {
    _watchlistRepository
        .addWatchlist(contentId: event.contentId, userId: event.userId)
        .then((_) {
      log('Watchlist added successfully', name: 'WatchlistBloc');
    }).catchError((error) {
      log('Failed to add watchlist: $error', name: 'WatchlistBloc');
    });
  }

  void _onDeleteWatchlist(
    DeleteWatchlist event,
    Emitter<WatchlistState> emit,
  ) {
    _watchlistRepository.deleteWatchlist(event.watchlistId).then((_) {
      log('Watchlist deleted successfully', name: 'WatchlistBloc');
    }).catchError((error) {
      log('Failed to delete watchlist: $error', name: 'WatchlistBloc');
    });
  }

  void _onDeleteWatchlistByContentId(
    DeleteWatchlistByContentId event,
    Emitter<WatchlistState> emit,
  ) {
    _watchlistRepository.deleteWatchlistByContentId(event.contentId).then((_) {
      log('Watchlist deleted successfully', name: 'WatchlistBloc');
    }).catchError((error) {
      log('Failed to delete watchlist: $error', name: 'WatchlistBloc');
    });
  }

  @override
  Future<void> close() {
    _watchlistSubscription?.cancel();
    _isWatchlistSubscription?.cancel();
    return super.close();
  }
}
