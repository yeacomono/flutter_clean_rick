import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/location_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/location_repository.dart';
import 'package:either_dart/either.dart';

/// UC --> Use case
class GetLocationsUC {
  final LocationRepository repository;

  GetLocationsUC(this.repository);

  Future<Either<Failure, List<LocationEntity>>> call(int page) async {
    return await repository.getAllLocations(page);
  }
}
