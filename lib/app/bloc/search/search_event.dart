part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadSearch extends SearchEvent {}

class SearchContent extends SearchEvent {
  final String title;
  final String genre;
  const SearchContent({required this.title, this.genre = ''});

  @override
  List<Object> get props => [title, genre];
}

class UpdateResult extends SearchEvent {
  final List<Content> contents;
  const UpdateResult(this.contents);
  @override
  List<Object> get props => [contents];
}
