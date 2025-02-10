import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/character_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/usecase/character/filter_character.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/usecase/character/get_characters.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  /// Get all characters use case
  final GetCharactersUC getCharactersUC;
  final FilterCharacterUC filterCharacterUC;
  int _currentPage = 1;
  bool isFetching = false;

  CharacterBloc(
      {required this.getCharactersUC, required this.filterCharacterUC})
      : super(CharacterInitial()) {
    on<CharacterEvent>((event, emit) {});
    on<AllCharacters>(allCaharacterEvent);
    on<FindCharacter>(findCharacter);
    on<FetchMoreCharacters>(fetchMoreCharacters);
  }

  Future<void> allCaharacterEvent(AllCharacters event, Emitter emit) async {
    emit(CharacterLoading());
    final latestSearch = await filterCharacterUC.call("");
    latestSearch.fold(
      (left) {
        emit(CharacterError(left.message));
      },
      (rigth) {
        if (rigth.isNotEmpty) {
          emit(CharacterLoaded(rigth));
          return;
        }
      },
    );
    if (event.page == 1) {
      _currentPage = 1;
    }
    final request = await getCharactersUC.call(event.page ?? _currentPage);
    request.fold(
      (left) {
        emit(CharacterError(left.message));
      },
      (rigth) {
        emit(CharacterLoaded(rigth));
      },
    );
  }

  Future<void> findCharacter(FindCharacter event, Emitter emit) async {
    emit(CharacterLoading());
    final result = await filterCharacterUC.call(event.name);
    result.fold(
      (left) {
        emit(CharacterError(left.message));
      },
      (rigth) {
        emit(CharacterLoaded(rigth));
      },
    );
  }

  Future<void> fetchMoreCharacters(
    FetchMoreCharacters event,
    Emitter emit,
  ) async {
    if (isFetching) return;
    isFetching = true;
    await Future.delayed(const Duration(seconds: 2));
    try {
      final currentState = state;
      if (currentState is CharacterLoaded) {
        final request = await getCharactersUC.call(_currentPage + 1);
        request.fold(
          (left) {
            emit(CharacterError(left.message));
          },
          (rigth) async {
            _currentPage++;
            var previusList = List.of(currentState.characters);
            previusList.addAll(rigth);
            emit(CharacterLoaded(previusList));
          },
        );
      }
    } catch (e) {
      add(const AllCharacters());
    } finally {
      isFetching = false;
    }
  }
}
