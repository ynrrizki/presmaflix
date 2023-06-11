import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/repositories/firestore/repositories.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ContentRepository _contentRepository;
  SearchCubit(this._contentRepository) : super(SearchState.initial());

  Future<void> signUpFormSubmitted() async {
    if (state.status == SearchStatus.changed) return;
    emit(state.copyWith(status: SearchStatus.changed));
    try {
      // await _authRepository.signUp(
      //   name: state.name,
      //   email: state.email,
      //   password: state.password,
      // );
      emit(state.copyWith(status: SearchStatus.changed));
    } on Exception {
      emit(state.copyWith(status: SearchStatus.error));
    }
  }
}
