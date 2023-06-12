import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/repositories/firestore/watchlist/watchlist_repo.dart';
import 'package:presmaflix/app/models/watchlist/watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepository _watchlistRepository;
  StreamSubscription? _watchlistSubscription;

  WatchlistBloc({required WatchlistRepository watchlistRepository})
      : _watchlistRepository = watchlistRepository,
        super(WatchlistLoading()) {
    on<LoadWatchlists>(_onLoadWatchlists);
    on<UpdateWatchlists>(_onUpdateWatchlists);
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
    // log(event.watchlists.toString());
    emit(WatchlistLoading());
    emit(WatchlistLoaded(watchlists: event.watchlists));
  }
}
