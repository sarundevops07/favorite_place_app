import 'package:favorite_place_app/models/place.dart';
import 'package:favorite_place_app/presentation/screeen/your_place_details_screen.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.places,
  });

  final List<PlaceModel> places;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
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
