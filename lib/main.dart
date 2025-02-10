import 'package:clean_arch_rick_and_morty/src/core/routers/app_router.dart';
import 'package:clean_arch_rick_and_morty/src/core/di/service_locator.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/character/character_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/episode/episode_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/location/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  /// Character open box
  await Hive.openBox('character_cache');
  await Hive.openBox('characters_search');

  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CharacterBloc>()),
        BlocProvider(create: (context) => getIt<EpisodeBloc>()),
        BlocProvider(create: (context) => getIt<LocationBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Rick and Morty',
        routerConfig: appRouter,
      ),
    );
  }
}
