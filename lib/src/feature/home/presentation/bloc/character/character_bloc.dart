import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/character_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/usecase/get_characters.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  /// Get all characters use case
  final GetCharactersUC getCharactersUC;

  CharacterBloc({required this.getCharactersUC}) : super(CharacterInitial()) {
    on<CharacterEvent>((event, emit) {});
    on<AllCharacters>(allCaharacterEvent);
    on<FindCharacter>(findCharacter);
  }

  Future<void> allCaharacterEvent(AllCharacters event, Emitter emit) async {
    emit(CharacterLoading());
    final request = await getCharactersUC.call(event.page ?? 1);
    request.fold(
      (left) {
        emit(CharacterError(left.message));
      },
      (rigth) {
        emit(CharacterLoaded(rigth));
      },
    );
  }

  Future<void> findCharacter(FindCharacter event, Emitter emit) async {}
}
