import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/models/character_model.dart';

abstract class CharacterDatasource {
  Future<List<CharacterModel>> getAllCharacters(int page);

  Future<CharacterModel> getCharacterById(int id);

  Future<List<CharacterModel>> getMultyCharacters(
    List<int> ids,
  );

  Future<CharacterModel> filterCharacters({
    String? name,
    String? species,
    String? status,
    String? origin,
    String? location,
  });
}
