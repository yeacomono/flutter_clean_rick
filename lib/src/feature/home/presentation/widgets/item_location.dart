import 'package:clean_arch_rick_and_morty/src/feature/home/domain/entity/location_entity.dart';
import 'package:flutter/material.dart';

class LocationItem extends StatelessWidget {
  final LocationEntity location;
  final VoidCallback? onTap;

  const LocationItem({
    super.key,
    required this.location,
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
          location.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("${location.type} - ${location.dimension}"),
        trailing: const Icon(Icons.location_on, color: Colors.blue),
      ),
    );
  }
}
