import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class InputImage extends StatefulWidget {
  const InputImage({super.key, required this.onSaveImage});
  final Function(File image) onSaveImage;

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? pickedImagePath;

  void takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    // if (pickedImage == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     backgroundColor: Theme.of(context).colorScheme.inverseSurface,
    //     content: Text('No image selected. Please select an image.',
    //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
    //             color: Theme.of(context).colorScheme.inversePrimary,
    //             fontWeight: FontWeight.bold)),
    //     duration: const Duration(seconds: 4),
    //   ));
    // }

    if (pickedImage != null) {
      setState(() {
        pickedImagePath = File(pickedImage.path);
      });
    }

    widget.onSaveImage(pickedImagePath!);

    // setState(() {
    //   pickedImagePath = File(pickedImage!.path);
    // });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: takePicture,
      label: const Text('Take Picture'),
      icon: const Icon(Icons.camera),
    );

    if (pickedImagePath != null) {
      content = GestureDetector(
        onTap: takePicture,
        child: ClipRRect(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                child: Image.file(
                  pickedImagePath!,
                  fit: BoxFit.cover,
                ),
              ),
              Image.file(
                pickedImagePath!,
                fit: BoxFit.scaleDown,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all()),
        child: content);
  }
}
