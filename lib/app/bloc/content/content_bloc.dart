import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/models/content/content.dart';
import 'package:presmaflix/app/repositories/firestore/content/content_repository.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRepository _contentRepository;
  StreamSubscription? _contentSubscription;

  ContentBloc({required ContentRepository contentRepository})
      : _contentRepository = contentRepository,
        super(ContentLoading()) {
    on<LoadContents>(_onLoadContents);
    on<UpdateContents>(_onUpdateContents);
  }

  void _onLoadContents(
    LoadContents event,
    Emitter<ContentState> emit,
  ) {
    log('when add LoadContents', name: 'ContentBloc');
    _contentSubscription?.cancel();
    _contentSubscription = _contentRepository.getAllContents().listen(
      (contents) {
        log('when add UpdateContents', name: 'ContentBloc');
        return add(
          UpdateContents(contents),
        );
      },
    );
  }

  void _onUpdateContents(
    UpdateContents event,
    Emitter<ContentState> emit,
  ) {
    // log(event.contents.toString());
    emit(ContentLoading());
    emit(ContentLoaded(contents: event.contents));
  }

  @override
  Future<void> close() async {
    _contentSubscription?.cancel();
    super.close;
  }
}
