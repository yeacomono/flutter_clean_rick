part of 'character_bloc.dart';

sealed class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<CharacterEntity> characters;
  const CharacterLoaded(this.characters);
  @override
  List<Object> get props => [characters];
}

class CharacterError extends CharacterState {
  final String message;
  const CharacterError(this.message);
}
