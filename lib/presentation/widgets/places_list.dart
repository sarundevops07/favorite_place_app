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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Delete Place'),
                    content: const Text(
                        'Are you sure you want to delete this place?'),
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
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final placeIdToDelete = places[index].id;
                          ref.read(
                            placeProvider.notifier.select(
                              (value) => value.deletePlace(placeIdToDelete),
                            ),
                          );
                          // Call the delete function
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(
                          'Delete',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onError,
                              ),
                        ),
                      ),
                    ],
                  );
                },
              );
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
