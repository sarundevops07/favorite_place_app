import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class PlaceModel {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  PlaceModel({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid;
}
