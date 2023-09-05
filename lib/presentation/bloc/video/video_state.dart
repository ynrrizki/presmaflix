part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final List<Video> videos;

  const VideoLoaded({this.videos = const <Video>[]});

  @override
  List<Object> get props => [videos];
}
