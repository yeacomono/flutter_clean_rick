import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/models/episode_model.dart';

abstract class EpisodeDatasource {
  Future<List<EpisodeModel>> getAllEpisode(int page);

  Future<EpisodeModel> getCharacterById(int id);

  Future<List<EpisodeModel>> getMultyEpisode(
    List<int> ids,
  );

  Future<EpisodeModel> filterEpisode({
    String? name,
    int? episode,
  });
}
