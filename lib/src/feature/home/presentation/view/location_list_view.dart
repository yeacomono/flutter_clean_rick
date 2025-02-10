import 'package:clean_arch_rick_and_morty/src/core/di/service_locator.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/episode/episode_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/bloc/location/location_bloc.dart';
import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/widgets/item_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationListView extends StatelessWidget {
  const LocationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      bloc: getIt<LocationBloc>()..add(const AllLocation()),
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LocationError) {
          final message = state.message;
          return Column(
            children: [
              const Icon(Icons.error),
              Text(message),
            ],
          );
        }
        if (state is LocationLoaded) {
          final locations = state.locations;
          return RefreshIndicator(
            onRefresh: () async {
              getIt<EpisodeBloc>().add(const AllEpisodes());
            },
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 20),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return LocationItem(
                  location: locations[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: locations.length,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
