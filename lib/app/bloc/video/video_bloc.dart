import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/app/models/video.dart';
import 'package:presmaflix/app/repositories/firestore/video/video_repository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _videoRepository;
  StreamSubscription? _videoSubscription;

  VideoBloc({required VideoRepository videoRepository})
      : _videoRepository = videoRepository,
        super(VideoLoading()) {
    on<LoadVideos>(_onLoadVideos);
    on<UpdateVideos>(_onUpdateContents);
  }

  void _onLoadVideos(
    LoadVideos event,
    Emitter<VideoState> emit,
  ) {
    log('when add LoadVideos', name: 'VideoBloc');
    _videoSubscription?.cancel();
    _videoSubscription =
        _videoRepository.getAllVideosByContent(event.content).listen(
      (videos) {
        log('when add UpdateVideos', name: 'ContentBloc');
        return add(
          UpdateVideos(videos),
        );
      },
    );
  }

  void _onUpdateContents(
    UpdateVideos event,
    Emitter<VideoState> emit,
  ) {
    // log(event.contents.toString());
    emit(VideoLoaded(videos: event.videos));
  }
}
