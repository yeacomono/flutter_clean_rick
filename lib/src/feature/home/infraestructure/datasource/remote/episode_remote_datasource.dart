import 'package:clean_arch_rick_and_morty/src/core/constant/enviroment.dart';
import 'package:clean_arch_rick_and_morty/src/core/error/exceptions.dart';
import 'package:clean_arch_rick_and_morty/src/core/network/api_client.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/episode_datasource.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/models/episode_model.dart';
import 'package:dio/dio.dart';

class EpisodeRemoteDatasource implements EpisodeDatasource {
  final client = APIClient(Enviroment.url);

  @override
  Future<EpisodeModel> filterEpisode({String? name, int? episode}) {
    throw UnimplementedError();
  }

  @override
  Future<List<EpisodeModel>> getAllEpisode(int page) async {
    const endPoint = '/episode';
    try {
      final request = await client.get(endPoint);
      if (request?.statusCode != 200) {
        throw ServerException();
      }
      var listCharacter = request?.data['results'] as List;
      final result = EpisodeModel.fromJsonList(listCharacter);
      return result;
    } on DioException {
      throw NetworkException();
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<EpisodeModel> getCharacterById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<EpisodeModel>> getMultyEpisode(List<int> ids) {
    throw UnimplementedError();
  }
}
