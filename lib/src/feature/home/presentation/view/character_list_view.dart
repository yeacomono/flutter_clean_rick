import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/character/character_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/screens/detail_character.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/widgets/item_characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CharacterListView extends StatefulWidget {
  const CharacterListView({super.key});

  @override
  State<CharacterListView> createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      final characterBloc = context.read<CharacterBloc>();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent &&
            !characterBloc.isFetching) {
          characterBloc.add(
            FetchMoreCharacters(),
          );
        }
      });
      characterBloc.add(const AllCharacters(page: 1));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
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
              context.read<CharacterBloc>().add(const AllCharacters(page: 1));
            },
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 20),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                if (index == characters.length + 1) {
                  return const Center(child: CircularProgressIndicator());
                }
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
              itemCount: characters.length +
                  (context.read<CharacterBloc>().isFetching ? 1 : 0),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
