import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/episode_entity.dart';
import 'package:flutter/material.dart';

class EpisodeItem extends StatelessWidget {
  final EpisodeEntity episode;
  final VoidCallback? onTap;

  const EpisodeItem({
    super.key,
    required this.episode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        onTap: onTap,
        title: Text(
          episode.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${episode.episode} - ${episode.airDate}"),
        trailing: const Icon(Icons.tv, color: Colors.green),
      ),
    );
  }
}
