import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/models/location_model.dart';

abstract class LocationDatasource {
  Future<List<LocationModel>> getAllLocations(int page);

  Future<LocationModel> getLocationById(int id);

  Future<List<LocationModel>> getMultyLocations(
    List<int> ids,
  );
  Future<LocationModel> filterLocations({
    String? name,
    String? type,
    String? dimension,
  });
}
