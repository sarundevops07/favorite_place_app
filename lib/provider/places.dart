import 'dart:io';
import 'package:favorite_place_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'places.db'), version: 1,
      onCreate: (Database db, int version) async {
    return db.execute(
        'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
  });
  return db;
}

class FavoriteNotifier extends StateNotifier<List<PlaceModel>> {
  FavoriteNotifier() : super([]);
  Future<void> loadPlace() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => PlaceModel(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');
    if (title.isEmpty || title.trim().length <= 1 || title.trim().length > 50) {
      return;
    }
    final newPlace =
        PlaceModel(title: title, image: copiedImage, location: location);
    try {
      final db = await _getDatabase();
      db.insert('user_places', {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'lat': newPlace.location.latitude,
        'lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      });
    } catch (e) {
      print(e.toString());
    }

    state = [...state, newPlace];
  }
}

final placeProvider = StateNotifierProvider<FavoriteNotifier, List<PlaceModel>>(
  (ref) => FavoriteNotifier(),
);
