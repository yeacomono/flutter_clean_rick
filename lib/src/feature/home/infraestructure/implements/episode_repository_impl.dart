import 'package:clean_arch_rick_and_morty/src/core/error/exceptions.dart';
import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/episode_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/episode_repository.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/remote/episode_remote_datasource.dart';
import 'package:either_dart/either.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {
  final EpisodeRemoteDatasource episodeRemote;
  EpisodeRepositoryImpl({required this.episodeRemote});
  @override
  Future<Either<Failure, EpisodeEntity>> filterEpisode(
      {String? name, int? episode}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EpisodeEntity>>> getAllEpisode(int page) async {
    try {
      final listmodels = await episodeRemote.getAllEpisode(page);
      final result = listmodels.map((v) {
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
  Future<Either<Failure, EpisodeEntity>> getCharacterById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EpisodeEntity>>> getMultyEpisode(List<int> ids) {
    throw UnimplementedError();
  }
}
