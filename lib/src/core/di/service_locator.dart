import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/character_repository.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/episode_repository.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/repository/location_repository.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/usecase/episode/get_episodes.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/usecase/get_characters.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/domain/usecase/location/get_locations.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/local/character_local_datasource.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/remote/character_remote_datasource.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/remote/episode_remote_datasource.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/datasource/remote/location_remote_datasource.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/implements/character_repository_impl.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/implements/episode_repository_impl.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/infraestructure/implements/location_repository_impl.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/character/character_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/episode/episode_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/location/location_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void serviceLocator() {
  /// REGISTER REPOSITORY
  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      characterRemote: CharacterRemoteDatasource(),
      characterLocal: CharaterLocalDatasource(),
    ),
  );
  getIt.registerLazySingleton<EpisodeRepository>(
    () => EpisodeRepositoryImpl(
      episodeRemote: EpisodeRemoteDatasource(),
    ),
  );
  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      episodeRemote: LocationRemoteDatasource(),
    ),
  );

  /// REGISTER USE CASE
  getIt.registerLazySingleton(() {
    return GetCharactersUC(getIt());
  });

  getIt.registerLazySingleton(() {
    return GetEpisodesUC(getIt());
  });
  getIt.registerLazySingleton(() {
    return GetLocationsUC(getIt());
  });

  /// REGISTER BLOC
  getIt.registerFactory<CharacterBloc>(
    () => CharacterBloc(getCharactersUC: getIt()),
  );

  getIt.registerFactory<EpisodeBloc>(
    () => EpisodeBloc(
      getEpisodesUC: getIt(),
    ),
  );
  getIt.registerFactory<LocationBloc>(
      () => LocationBloc(getLocationsUC: getIt()));
}
