import 'package:clean_arch_rick_and_morty/src/core/error/exceptions.dart';
import 'package:clean_arch_rick_and_morty/src/core/error/failures.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/location_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/location_repository.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/remote/location_remote_datasource.dart';
import 'package:either_dart/either.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDatasource episodeRemote;
  LocationRepositoryImpl({required this.episodeRemote});
  @override
  Future<Either<Failure, LocationEntity>> filterLocations(
      {String? name, String? type, String? dimension}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getAllLocations(
    int page,
  ) async {
    try {
      final listmodels = await episodeRemote.getAllLocations(page);
      final result = listmodels.map((v) {
        return v.toEntity();
      }).toList();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getLocationById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getMultyLocations(
      List<int> ids) {
    throw UnimplementedError();
  }
}
