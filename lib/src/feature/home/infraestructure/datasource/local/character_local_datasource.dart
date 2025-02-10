import 'package:clean_arch_rick_and_morty/src/core/error/exceptions.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/character_datasource.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/models/character_model.dart';
import 'package:hive/hive.dart';

class CharaterLocalDatasource implements CharacterDatasource {
  final Box _box = Hive.box('character_cache');

  @override
  Future<List<CharacterModel>> filterCharacters({
    String? name,
    String? species,
    String? status,
    String? origin,
    String? location,
  }) async {
    try {
      final data = _box.get('characters_search');
      if (data != null) {
        final list = List.from(data as List)
            .map((v) => Map<String, dynamic>.from(v as Map))
            .toList();
        return list.map((e) => CharacterModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<CharacterModel>> getAllCharacters(
    int page,
  ) async {
    try {
      final data = _box.get('characters_page_$page');
      if (data != null) {
        final list = List.from(data as List)
            .map((v) => Map<String, dynamic>.from(v as Map))
            .toList();
        return list.map((e) => CharacterModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> saveCacheCharacters(
    int page,
    List<CharacterModel> characters,
  ) async {
    try {
      final jsonList = characters.map((c) => c.toJson()).toList();
      await _box.put('characters_page_$page', jsonList);
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> saveSearchCacheCharacters(
    List<CharacterModel> characters,
  ) async {
    try {
      final jsonList = characters.map((c) => c.toJson()).toList();
      await _box.put('characters_search', jsonList);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<CharacterModel>> getMultyCharacters(List<int> ids) {
    throw UnimplementedError();
  }
}
