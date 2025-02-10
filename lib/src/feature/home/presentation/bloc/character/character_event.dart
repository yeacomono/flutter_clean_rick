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
  final int id;
  const FindCharacter(this.id);
  @override
  List<Object> get props => [id];
}

class FilterCharacter extends CharacterEvent {
  @override
  List<Object> get props => [];
}
