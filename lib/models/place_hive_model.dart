import 'dart:io';

import 'package:favorite_place_app/models/place.dart';
import 'package:hive_flutter/adapters.dart';
part 'place_hive_model.g.dart';

@HiveType(typeId: 1)
class HivePlaceModel {
  PlaceModel toPlaceModel() {
    return PlaceModel(
      id: id ?? uuid,
      title: title,
      image: File(imagePath),
      location: PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      ),
    );
  }

  @HiveField(0)
  String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imagePath;

  @HiveField(3)
  final double latitude;

  @HiveField(4)
  final double longitude;

  @HiveField(5)
  final String address;

  HivePlaceModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}
