import 'dart:io';

import 'package:favorite_place_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<List<PlaceModel>> {
  FavoriteNotifier() : super([]);

  void addPlace(String title, File image, PlaceLocation location) {
    if (title.isEmpty || title.trim().length <= 1 || title.trim().length > 50) {
      return;
    }
    final newPlace = PlaceModel(title: title, image: image, location: location);
    state = [...state, newPlace];
  }
}

final placeProvider = StateNotifierProvider<FavoriteNotifier, List<PlaceModel>>(
    (ref) => FavoriteNotifier());
