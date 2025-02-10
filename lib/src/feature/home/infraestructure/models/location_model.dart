import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/location_entity.dart';

class LocationModel {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;

  const LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
  });

  // Convertir JSON a Modelo
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      dimension: json["dimension"],
      residents: List<String>.from(json["residents"]),
    );
  }

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      name: name,
      type: type,
      dimension: dimension,
      residents: residents,
    );
  }

  static List<LocationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LocationModel.fromJson(json)).toList();
  }
}
