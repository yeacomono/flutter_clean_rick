import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/episode_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/episode_repository.dart';
import 'package:either_dart/either.dart';

/// UC --> Use case
class GetEpisodesUC {
  final EpisodeRepository repository;

  GetEpisodesUC(this.repository);

  Future<Either<Failure, List<EpisodeEntity>>> call(int page) async {
    return await repository.getAllEpisode(page);
  }
}
