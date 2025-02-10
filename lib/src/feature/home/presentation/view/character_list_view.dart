import 'package:clean_arch_rick_and_morty/src/core/di/service_locator.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/character/character_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/screens/detail_character.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/widgets/item_characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: getIt<CharacterBloc>()..add(const AllCharacters()),
      builder: (context, state) {
        if (state is CharacterLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CharacterError) {
          final message = state.message;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error),
              Text(message),
            ],
          );
        }
        if (state is CharacterLoaded) {
          final characters = state.characters;
          return RefreshIndicator(
            onRefresh: () async {
              getIt<CharacterBloc>().add(const AllCharacters());
            },
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 20),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return CharacterCard(
                  character: characters[index],
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                      CharacterDetailScreen.name,
                      extra: characters[index],
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: characters.length,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
