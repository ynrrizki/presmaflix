import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/bloc/blocs.dart';
import 'package:presmaflix/app/repositories/firestore/repositories.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ContentRepository _contentRepository;
  final SearchBloc _searchBloc;
  SearchCubit(this._contentRepository, this._searchBloc)
      : super(SearchState.initial());

  Future<void> searchChanged({required String title, String genre = ''}) async {
    if (state.status == SearchStatus.changed) return;
    emit(state.copyWith(status: SearchStatus.changed));
    try {
      // await _authRepository.signUp(
      //   name: state.name,
      //   email: state.email,
      //   password: state.password,
      // );
      _searchBloc.add(
        SearchContent(title: title, genre: genre),
      );
      emit(state.copyWith(status: SearchStatus.changed));
    } on Exception {
      emit(state.copyWith(status: SearchStatus.error));
    }
  }
}
