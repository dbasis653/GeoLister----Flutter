import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path/path.dart' as path;

import 'package:sqflite/sqflite.dart' as sql;
// import 'package:sqflite/sqlite_api.dart';

import 'package:fav_lister/model/place_model.dart';

Future<sql.Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    },
    version: 1,
  );
  return db;
}

class PlaceProviderNotifier extends StateNotifier<List<PlaceModel>> {
  PlaceProviderNotifier() : super([]);

  Future<void> loadItemsFromDatabase() async {
    final db = await getDatabase();
    final data = await db.query('user_places');
    final finalData = data
        .map(
          (rowData) => PlaceModel(
            placeName: rowData['title'] as String,
            image: File(rowData['image'] as String),
            id: rowData['id'] as String,
          ),
        )
        .toList();

    state = finalData;
  }

  void addPlace(PlaceModel place) async {
    final db = await getDatabase();
    db.insert('user_places', {
      'id': place.id,
      'title': place.placeName,
      'image': place.image.path,
    });

    state = [place, ...state];
  }

  void removePlace(PlaceModel place) async {
    final db = await getDatabase();
    await db.delete(
      'user_places',
      where: 'id = ?',
      whereArgs: [place.id],
    );
    state = state.where((m) => m.id != place.id).toList();
  }
}

final placeProvider =
    StateNotifierProvider<PlaceProviderNotifier, List<PlaceModel>>(
        (ref) => PlaceProviderNotifier());
