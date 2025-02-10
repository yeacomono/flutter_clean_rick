import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/character_entity.dart';

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originName;
  final String originUrl;
  final String locationName;
  final String locationUrl;
  final String image;
  final List<String> episodes;
  final String url;
  final String created;

  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originName,
    required this.originUrl,
    required this.locationName,
    required this.locationUrl,
    required this.image,
    required this.episodes,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "Unknown",
      status: json["status"] ?? "Unknown",
      species: json["species"] ?? "Unknown",
      type: json["type"] ?? "",
      gender: json["gender"] ?? "Unknown",
      originName: json["origin"]?["name"] ?? "Unknown",
      originUrl: json["origin"]?["url"] ?? "",
      locationName: json["location"]?["name"] ?? "Unknown",
      locationUrl: json["location"]?["url"] ?? "",
      image: json["image"] ?? "",
      episodes: (json["episode"] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      url: json["url"] ?? "",
      created: json["created"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "status": status,
      "species": species,
      "type": type,
      "gender": gender,
      "origin": {
        "name": originName,
        "url": originUrl,
      },
      "location": {
        "name": locationName,
        "url": locationUrl,
      },
      "image": image,
      "episode": episodes,
      "url": url,
      "created": created,
    };
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      originName: originName,
      originUrl: originUrl,
      locationName: locationName,
      locationUrl: locationUrl,
      image: image,
      episodes: episodes,
      url: url,
      created: created,
    );
  }

  static List<CharacterModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CharacterModel.fromJson(json)).toList();
  }
}
