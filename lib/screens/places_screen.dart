import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fav_lister/model/place_model.dart';
import 'package:fav_lister/providers/place_provider.dart';
import 'package:fav_lister/widgets/display_place_list.dart';
import 'package:fav_lister/screens/add_place_screen.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _toLoadPlaces;
  @override
  void initState() {
    super.initState();
    _toLoadPlaces = ref.read(placeProvider.notifier).loadItemsFromDatabase();
    // ref.read(placeProvider.notifier).loadItemsFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    List<PlaceModel> placesList = ref.watch(placeProvider);

    // Widget content = DisplayPlaceList(placeList: placesList);

    Widget content = FutureBuilder(
      future: _toLoadPlaces,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : DisplayPlaceList(
                  placeList: placesList,
                ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddPlaceScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add_a_photo))
        ],
      ),
      body: content,
    );
  }
}
