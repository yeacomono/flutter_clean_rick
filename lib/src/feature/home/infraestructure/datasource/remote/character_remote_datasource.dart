import 'package:clean_arch_rick_and_morty/src/core/constant/enviroment.dart';
import 'package:clean_arch_rick_and_morty/src/core/error/exceptions.dart';
import 'package:clean_arch_rick_and_morty/src/core/network/api_client.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/character_datasource.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/models/character_model.dart';
import 'package:dio/dio.dart';

class CharacterRemoteDatasource implements CharacterDatasource {
  final client = APIClient(Enviroment.url);

  @override
  Future<CharacterModel> filterCharacters(
      {String? name,
      String? species,
      String? status,
      String? origin,
      String? location}) {
    throw UnimplementedError();
  }

  @override
  Future<List<CharacterModel>> getAllCharacters(
    int page,
  ) async {
    const endPoint = '/character';
    try {
      final request = await client.get(endPoint);
      if (request?.statusCode != 200) {
        throw ServerException();
      }
      var listCharacter = request?.data['results'] as List;
      final result = CharacterModel.fromJsonList(listCharacter);
      return result;
    } on DioException {
      throw NetworkException();
    } catch (e) {
      throw UnknownException();
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
