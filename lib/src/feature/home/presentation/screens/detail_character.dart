import 'package:flutter/material.dart';
import '../../domain/entity/character_entity.dart';

class CharacterDetailScreen extends StatefulWidget {
  static const String name = "CharacterDetailScreen";
  final CharacterEntity character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.character.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Chip(
                    label: Text(
                      widget.character.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: _getStatusColor(widget.character.status),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildTitle("Character Details"),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                  _buildInfoTile("Species", widget.character.species),
                  _buildInfoTile(
                      "Type",
                      widget.character.type.isNotEmpty
                          ? widget.character.type
                          : "Unknown"),
                  _buildInfoTile("Gender", widget.character.gender),
                  _buildInfoTile("Origin", widget.character.originName),
                  _buildInfoTile("Location", widget.character.locationName),
                  _buildInfoTile(
                      "First Appearance",
                      widget.character.episodes.isNotEmpty
                          ? widget.character.episodes.first
                          : "Unknown"),
                  _buildInfoTile("Created", widget.character.created),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (widget.character.episodes.isNotEmpty) ...[
              _buildTitle("Episodes"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: widget.character.episodes.map((episode) {
                    return Chip(
                      label: Text(
                        episode.split('/').last,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ), // Extrae el número del episodio
                      backgroundColor: Colors.green[700],
                    );
                  }).toList(),
                ),
              ),
            ],
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(label,
            style: const TextStyle(color: Colors.grey, fontSize: 14)),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "alive":
        return Colors.green;
      case "dead":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
