import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/character_entity.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/screens/detail_character.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/screens/home_screen.dart';
import 'package:clean_arch_rick_and_morty/src/feature/initial/presentation/screens/initial_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/${InitialScreen.name}',
  routes: [
    GoRoute(
      path: '/${HomeScreen.name}',
      name: HomeScreen.name,
      builder: (_, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/${InitialScreen.name}',
      name: InitialScreen.name,
      builder: (_, state) => const InitialScreen(),
    ),
    GoRoute(
      path: '/${CharacterDetailScreen.name}',
      name: CharacterDetailScreen.name,
      builder: (_, state) {
        final character = state.extra;
        return CharacterDetailScreen(
          character: character as CharacterEntity,
        );
      },
    ),
  ],
);
