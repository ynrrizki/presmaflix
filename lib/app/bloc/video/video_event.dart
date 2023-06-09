part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class LoadVideos extends VideoEvent {}

class LoadVideosByContent extends VideoEvent {
  final Content content;
  const LoadVideosByContent(this.content);

  @override
  List<Object> get props => [content];
}

class UpdateVideos extends VideoEvent {
  final List<Video> videos;
  const UpdateVideos(this.videos);

  @override
  List<Object> get props => [videos];
}
