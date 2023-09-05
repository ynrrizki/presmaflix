import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:presmaflix/data/models/content/content.dart';
import 'package:presmaflix/data/models/video/video.dart';
import 'package:presmaflix/data/repositories/firestore/video/video_repository.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _videoRepository;
  StreamSubscription? _videoSubscription;

  VideoBloc({required VideoRepository videoRepository})
      : _videoRepository = videoRepository,
        super(VideoLoading()) {
    on<LoadVideos>(_onLoadVideos);
    on<LoadVideosByContent>(_onLoadVideosByContent);
    on<UpdateVideos>(_onUpdateVideos);
  }

  void _onLoadVideos(LoadVideos event, Emitter<VideoState> emit) {
    _videoSubscription?.cancel();
    _videoSubscription = _videoRepository.getAllVideos().listen(
      (videos) {
        log('when add UpdateVideos', name: 'VideoBloc');
        return add(
          UpdateVideos(videos),
        );
      },
    );
  }

  void _onLoadVideosByContent(
      LoadVideosByContent event, Emitter<VideoState> emit) {
    log('when add LoadVideos', name: 'VideoBloc');
    // log(event.content.id.toString(), name: 'log id content');
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

  void _onUpdateVideos(UpdateVideos event, Emitter<VideoState> emit) {
    log('execute', name: 'UpdateVideos');
    emit(VideoLoading());
    emit(VideoLoaded(videos: event.videos));
  }

  @override
  Future<void> close() async {
    _videoSubscription?.cancel();
    super.close;
  }
}
