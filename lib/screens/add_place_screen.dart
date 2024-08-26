import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart' as sys_path;
import 'package:path/path.dart' as path;

import 'package:fav_lister/model/place_model.dart';
import 'package:fav_lister/providers/place_provider.dart';
import 'package:fav_lister/widgets/form/form_placename.dart';
import 'package:fav_lister/widgets/form/input_image.dart';

final formKey = GlobalKey<FormState>();

class AddPlaceScreen extends ConsumerWidget {
  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String inputPlaceName = '';
    File? pickedImage;

    // void onSaveImage(){

    // }

    void savePlace() async {
      print('Saving..........');
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        if (pickedImage != null) {
          final appDirectory =
              await sys_path.getApplicationDocumentsDirectory();
          final imageName = path.basename(pickedImage!.path);
          final pickedImagePath =
              await pickedImage!.copy('${appDirectory.path}/$imageName');

          ref.read(placeProvider.notifier).addPlace(
                PlaceModel(placeName: inputPlaceName, image: pickedImagePath),
              );
        }
        print('Saving Done...');
      }
      Navigator.pop(context);
      print('Pop executed...');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MyForm(
                formKey: formKey,
                onSaveFunction: (value) => inputPlaceName = value),
            const SizedBox(height: 20),
            InputImage(
              onSaveImage: (image) {
                pickedImage = image;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: savePlace,
              label: const Text('Add Place'),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
      ),
    );
  }
}
