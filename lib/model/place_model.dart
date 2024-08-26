import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel {
  PlaceModel({
    required this.placeName,
    required this.image,
    String? id,
  }) : id = id ?? uuid.v4();
  // PlaceModel({required this.placeName}) : id = uuid.v4();

  final String placeName;
  final File image;
  final String id;
}
