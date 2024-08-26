import 'package:flutter/material.dart';
import 'package:fav_lister/model/place_model.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});
  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.placeName),
      ),
    );
  }
}
