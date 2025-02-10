import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/character/character_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/view/character_list_view.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/view/episode_list_view.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/view/location_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Text('Rick and Morty App'),
          //// THIS IS FOR THEME APP
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.settings,
          //       size: 30,
          //     ),
          //   ),
          //   const SizedBox(
          //     width: 30,
          //   ),
          // ],
          centerTitle: false,
          titleSpacing: 20,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(
              80,
            ), // Espacio para el `TabBar` y el `TextField`
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    onChanged: (value) {
                      context.read<CharacterBloc>().add(
                            FindCharacter(value),
                          );
                    },
                    decoration: InputDecoration(
                      hintText: "Search characters...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(text: 'Characters'),
                    Tab(text: 'Location'),
                    Tab(text: 'Episode'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            CharacterListView(),
            LocationListView(),
            EpisodeListView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.favorite),
          onPressed: () {},
        ),
      ),
    );
  }
}
