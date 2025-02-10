import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/location_entity.dart';
import 'package:either_dart/either.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<LocationEntity>>> getAllLocations(int page);

  Future<Either<Failure, LocationEntity>> getLocationById(int id);

  Future<Either<Failure, List<LocationEntity>>> getMultyLocations(
    List<int> ids,
  );

  Future<Either<Failure, LocationEntity>> filterLocations({
    String? name,
    String? type,
    String? dimension,
  });
}
