part of 'character_bloc.dart';

sealed class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class AllCharacters extends CharacterEvent {
  final int? page;
  const AllCharacters({this.page});
  @override
  List<Object> get props => [page ?? 1];
}

class FindCharacter extends CharacterEvent {
  final String name;
  const FindCharacter(this.name);
  @override
  List<Object> get props => [name];
}

class FilterCharacter extends CharacterEvent {
  @override
  List<Object> get props => [];
}

class FetchMoreCharacters extends CharacterEvent {
  @override
  List<Object> get props => [];
}
