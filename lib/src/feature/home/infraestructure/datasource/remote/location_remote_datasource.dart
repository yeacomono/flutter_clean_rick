import 'package:clean_arch_rick_and_morty/src/core/constant/enviroment.dart';
import 'package:clean_arch_rick_and_morty/src/core/error/exceptions.dart';
import 'package:clean_arch_rick_and_morty/src/core/network/api_client.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/location_datasource.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/models/location_model.dart';
import 'package:dio/dio.dart';

class LocationRemoteDatasource implements LocationDatasource {
  final client = APIClient(Enviroment.url);

  @override
  Future<LocationModel> filterLocations(
      {String? name, String? type, String? dimension}) {
    throw UnimplementedError();
  }

  @override
  Future<List<LocationModel>> getAllLocations(int page) async {
    const endPoint = '/location';
    try {
      final request = await client.get(endPoint);
      if (request?.statusCode != 200) {
        throw ServerException();
      }
      var listModels = request?.data['results'] as List;
      final result = LocationModel.fromJsonList(listModels);
      return result;
    } on DioException {
      throw NetworkException();
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<LocationModel> getLocationById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<LocationModel>> getMultyLocations(List<int> ids) {
    throw UnimplementedError();
  }
}
