import 'package:fav_lister/providers/place_provider.dart';
import 'package:flutter/material.dart';

import 'package:fav_lister/model/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_lister/screens/place_details_screen.dart';

class DisplayPlaceList extends ConsumerWidget {
  const DisplayPlaceList({super.key, required this.placeList});
  final List<PlaceModel> placeList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: placeList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Dismissible(
          key: ValueKey(placeList[index]),
          onDismissed: (direction) {
            ref.read(placeProvider.notifier).removePlace(placeList[index]);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlaceDetailsScreen(
                    place: placeList[index],
                  ),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    placeList[index].image,
                  ),
                  radius: 25,
                ),
                title: Text(
                  placeList[index].placeName,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
