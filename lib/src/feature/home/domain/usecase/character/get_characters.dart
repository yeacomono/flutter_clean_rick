import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/character_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/character_repository.dart';
import 'package:either_dart/either.dart';

/// UC --> Use case
class GetCharactersUC {
  final CharacterRepository repository;

  GetCharactersUC(this.repository);

  Future<Either<Failure, List<CharacterEntity>>> call(int page) async {
    return await repository.getAllCharacters(page);
  }
}
