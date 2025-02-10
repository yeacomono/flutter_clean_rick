import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/episode_entity.dart';
import 'package:either_dart/either.dart';

abstract class EpisodeRepository {
  Future<Either<Failure, List<EpisodeEntity>>> getAllEpisode(int page);

  Future<Either<Failure, EpisodeEntity>> getCharacterById(int id);

  Future<Either<Failure, List<EpisodeEntity>>> getMultyEpisode(
    List<int> ids,
  );

  Future<Either<Failure, EpisodeEntity>> filterEpisode({
    String? name,
    int? episode,
  });
}
