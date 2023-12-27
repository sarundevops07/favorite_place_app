import 'package:favorite_place_app/provider/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_place_app/models/place.dart';
import 'package:favorite_place_app/presentation/screeen/your_place_details_screen.dart';
import 'package:flutter/material.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({
    super.key,
    required this.places,
  });

  final List<PlaceModel> places;
  void _deletePlace(BuildContext context, WidgetRef ref, int index) {
    int deletedIndex = index;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Place'),
          content: const Text('Are you sure you want to delete this place?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            TextButton(
              onPressed: () {
                final place = places[index];
                final placeIdToDelete = place.id;
                // Call the delete function
                ref.read(
                  placeProvider.notifier.select(
                    (value) => value.deletePlace(placeIdToDelete),
                  ),
                );
                // show snackbar
                showSnackBar(context, ref, deletedIndex);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onError,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(BuildContext context, WidgetRef ref, int index) {
    final place = places[index];
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          'Your favorite place ${place.title} is deleted',
        ),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              ref.read(placeProvider.notifier.select(
                (value) => value.insertPlace(place, index),
              ));
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            onLongPress: () {
              _deletePlace(context, ref, index);
            },
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(place.image),
            ),
            title: Text(
              place.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              place.location.address,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return YourPlaceDetailsScreen(
                      place: place,
                    );
                  },
                ),
              );
            },
          );
        },
        itemCount: places.length,
      ),
    );
  }
}
