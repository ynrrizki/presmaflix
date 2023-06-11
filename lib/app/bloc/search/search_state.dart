part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Content> contents;
  const SearchLoaded({this.contents = const <Content>[]});

  @override
  List<Object> get props => [contents];
}
