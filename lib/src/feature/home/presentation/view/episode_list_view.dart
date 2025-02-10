import 'package:clean_arch_rick_and_morty/src/core/di/service_locator.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/episode/episode_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/widgets/item_episodes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodeListView extends StatelessWidget {
  const EpisodeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeBloc, EpisodeState>(
      bloc: getIt<EpisodeBloc>()..add(const AllEpisodes()),
      builder: (context, state) {
        if (state is EpisodeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is EpisodeError) {
          final message = state.message;
          return Column(
            children: [
              const Icon(Icons.error),
              Text(message),
            ],
          );
        }
        if (state is EpisodeLoaded) {
          final episodes = state.episodes;
          return RefreshIndicator(
            onRefresh: () async {
              getIt<EpisodeBloc>().add(const AllEpisodes());
            },
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 20),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return EpisodeItem(
                  episode: episodes[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: episodes.length,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
