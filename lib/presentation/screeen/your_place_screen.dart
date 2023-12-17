import 'package:favorite_place_app/presentation/widgets/places_list.dart';
import 'package:favorite_place_app/provider/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourPlaceScreen extends ConsumerStatefulWidget {
  const YourPlaceScreen({super.key});

  @override
  ConsumerState<YourPlaceScreen> createState() => _YourPlaceScreenState();
}

class _YourPlaceScreenState extends ConsumerState<YourPlaceScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    _placesFuture = ref.read(
      (placeProvider.notifier).select(
        (value) => value.loadPlace(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          : FutureBuilder(
              future: _placesFuture,
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).colorScheme.error),
                    )
                  : PlacesList(places: places),
            ),
    );
  }
}
