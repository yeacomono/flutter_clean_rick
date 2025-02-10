import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/character_entity.dart';
import 'package:either_dart/either.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(int page);

  Future<Either<Failure, CharacterEntity>> getCharacterById(int id);

  Future<Either<Failure, List<CharacterEntity>>> getMultyCharacters(
    List<int> ids,
  );

  Future<Either<Failure, List<CharacterEntity>>> filterCharacters({
    String? name,
    String? species,
    String? status,
    String? origin,
    String? location,
  });
}
