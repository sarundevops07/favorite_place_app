import 'dart:io';
import 'package:favorite_place_app/models/place.dart';
import 'package:favorite_place_app/models/place_hive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:sqflite/sqlite_api.dart';

// Future<Database> _getDatabase() async {
//   final dbPath = await sql.getDatabasesPath();
//   final db = await sql.openDatabase(path.join(dbPath, 'places.db'), version: 1,
//       onCreate: (Database db, int version) async {
//     return db.execute(
//         'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
//   });
//   return db;
// }

Future<Box<HivePlaceModel>> _getHiveBox() async {
  return await Hive.openBox<HivePlaceModel>('user_places');
}

class FavoriteNotifier extends StateNotifier<List<PlaceModel>> {
  FavoriteNotifier() : super([]);
  // Future<void> loadPlace() async {
  //   final db = await _getDatabase();

  //   final data = await db.query('user_places');
  //   final places = data
  //       .map(
  //         (row) => PlaceModel(
  //           id: row['id'] as String,
  //           title: row['title'] as String,
  //           image: File(row['image'] as String),
  //           location: PlaceLocation(
  //             latitude: row['lat'] as double,
  //             longitude: row['lng'] as double,
  //             address: row['address'] as String,
  //           ),
  //         ),
  //       )
  //       .toList();
  //   state = places;
  // }

  // void addPlace(String title, File image, PlaceLocation location) async {
  //   final appDir = await syspaths.getApplicationDocumentsDirectory();
  //   final fileName = path.basename(image.path);
  //   final copiedImage = await image.copy('${appDir.path}/$fileName');
  //   if (title.isEmpty || title.trim().length <= 1 || title.trim().length > 50) {
  //     return;
  //   }
  //   final newPlace =
  //       PlaceModel(title: title, image: copiedImage, location: location);
  //   try {
  //     final db = await _getDatabase();

  //     db.insert('user_places', {
  //       'id': newPlace.id,
  //       'title': newPlace.title,
  //       'image': newPlace.image.path,
  //       'lat': newPlace.location.latitude,
  //       'lng': newPlace.location.longitude,
  //       'address': newPlace.location.address,
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }

  //   state = [...state, newPlace];
  // }

  // void deletePlace(String placeId) async {
  //   final db = await _getDatabase();
  //   await db.delete('user_places', where: 'id = ?', whereArgs: [placeId]);

  //   state = state.where((place) => place.id != placeId).toList();
  // }
  Future<void> loadPlace() async {
    final box = await _getHiveBox();
    final List<HivePlaceModel> places = box.values.toList();
    state = places.map((hivePlace) => hivePlace.toPlaceModel()).toList();
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');
    if (title.isEmpty || title.trim().length <= 1 || title.trim().length > 50) {
      return;
    }
    final newPlace = HivePlaceModel(
      id: UniqueKey()
          .toString(), // You might want to use a different method to generate IDs
      title: title, address: location.address, imagePath: copiedImage.path,
      latitude: location.latitude, longitude: location.longitude,
    );

    final box = await _getHiveBox();
    await box.put(newPlace.id, newPlace);

    state = [...state, newPlace.toPlaceModel()];
  }

  Future<void> deletePlace(String placeId) async {
    final box = await _getHiveBox();
    await box.delete(placeId);

    state = state.where((place) => place.id != placeId).toList();
  }
}

final placeProvider = StateNotifierProvider<FavoriteNotifier, List<PlaceModel>>(
  (ref) => FavoriteNotifier(),
);
