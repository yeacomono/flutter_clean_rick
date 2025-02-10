import 'package:clean_arch_rick_and_morty/src/core/error/exceptions.dart';
import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/character_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/character_repository.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/local/character_local_datasource.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/remote/character_remote_datasource.dart';
import 'package:either_dart/either.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDatasource characterRemote;
  final CharaterLocalDatasource characterLocal;
  CharacterRepositoryImpl({
    required this.characterRemote,
    required this.characterLocal,
  });

  @override
  Future<Either<Failure, List<CharacterEntity>>> filterCharacters({
    String? name,
    String? species,
    String? status,
    String? origin,
    String? location,
  }) async {
    try {
      if (name == "") {
        final models = await characterLocal.filterCharacters(name: name);
        final result = models.map((v) {
          return v.toEntity();
        }).toList();
        return Right(result);
      }
      final listCharacters = await characterRemote.filterCharacters(
        name: name,
        species: species,
        status: status,
        origin: origin,
        location: location,
      );
      await characterLocal.saveSearchCacheCharacters(listCharacters);
      final result = listCharacters.map((v) {
        return v.toEntity();
      }).toList();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(
    int page,
  ) async {
    try {
      final localCharacters = await characterLocal.getAllCharacters(page);
      final resultLocal = localCharacters.map((v) {
        return v.toEntity();
      }).toList();
      if (localCharacters.isNotEmpty) {
        return Right(resultLocal);
      }
      final listCharacters = await characterRemote.getAllCharacters(page);
      await characterLocal.saveCacheCharacters(page, listCharacters);
      final result = listCharacters.map((v) {
        return v.toEntity();
      }).toList();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, CharacterEntity>> getCharacterById(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> getMultyCharacters(
      List<int> ids) async {
    throw UnimplementedError();
  }
}
