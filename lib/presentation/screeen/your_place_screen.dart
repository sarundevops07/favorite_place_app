import 'package:favorite_place_app/presentation/widgets/places_list.dart';
import 'package:favorite_place_app/provider/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourPlaceScreen extends ConsumerWidget {
  const YourPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "AddNewPlaceScreen");
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: places.isEmpty
          ? Center(
              child: Text(
                'No favorite places added',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : PlacesList(places: places),
    );
  }
}
