import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/episode_entity.dart';

class EpisodeModel {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;

  const EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
  });

  // Convertir JSON a Modelo
  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json["id"],
      name: json["name"],
      airDate: json["air_date"],
      episode: json["episode"],
      characters: List<String>.from(json["characters"]),
    );
  }

  // Convertir Modelo a Entidad (para la capa de dominio)
  EpisodeEntity toEntity() {
    return EpisodeEntity(
      id: id,
      name: name,
      airDate: airDate,
      episode: episode,
      characters: characters,
    );
  }

  static List<EpisodeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EpisodeModel.fromJson(json)).toList();
  }
}
