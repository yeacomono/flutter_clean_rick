import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/character_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/character_repository.dart';
import 'package:either_dart/either.dart';

/// UC --> Use case
class FilterCharacterUC {
  final CharacterRepository repository;

  FilterCharacterUC(this.repository);

  Future<Either<Failure, List<CharacterEntity>>> call(String name) async {
    return await repository.filterCharacters(name: name);
  }
}
