import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/view/character_list_view.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/view/episode_list_view.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/view/location_list_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Characters'),
              Tab(text: 'Location'),
              Tab(text: 'Episode'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CharacterListView(),
            LocationListView(),
            EpisodeListView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.favorite),
          onPressed: () {
            // getIt<CharacterBloc>().add()
          },
        ),
      ),
    );
  }
}
