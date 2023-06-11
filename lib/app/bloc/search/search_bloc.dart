import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/bloc/blocs.dart';
// import 'package:presmaflix/app/repositories/firestore/repositories.dart';
import 'package:presmaflix/app/models/content.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ContentBloc _contentBloc;
  StreamSubscription? _contentSubscription;

  SearchBloc({required ContentBloc contentBloc})
      : _contentBloc = contentBloc,
        super(SearchLoading()) {
    // on<SearchEvent>((event, emit) {});
    on<LoadSearch>(_onLoadSearch);
    on<SearchContent>(_onSearchContent);
    on<UpdateResult>(_onUpdateResult);
  }

  void _onLoadSearch(LoadSearch event, Emitter<SearchState> emit) {
    emit(SearchLoading());
  }

  void _onSearchContent(SearchContent event, Emitter<SearchState> emit) {
    List<Content> contents = (_contentBloc.state as ContentLoaded).contents;
    List<Content> searchResult = contents;

    if (event.title.isNotEmpty) {
      searchResult = searchResult
          .where((content) =>
              content.title.toLowerCase().contains(event.title.toLowerCase()))
          .toList();
      emit(SearchLoaded(contents: searchResult));
    }

    if (event.genre.isNotEmpty) {
      searchResult = searchResult
          .where(
            (content) => content.genre.contains(event.genre),
          )
          .toList();
      emit(SearchLoaded(contents: searchResult));
    }

    emit(SearchLoaded(contents: searchResult));
  }

  void _onUpdateResult(UpdateResult event, Emitter<SearchState> emit) {}

  @override
  Future<void> close() async {
    _contentSubscription?.cancel();
    super.close;
  }
}
