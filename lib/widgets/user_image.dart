import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImage extends StatefulWidget {
  const UserImage({super.key, required this.onPickImage});
  final void Function(File pickImage) onPickImage;

  @override
  State<StatefulWidget> createState() {
    return _UserImageState();
  }
}

class _UserImageState extends State<UserImage> {
  File? _pickImageFile;

  void _pickImage() async {
    final pickImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickImage == null) {
      return; // User cancelled the image picking process
    }
    setState(() {
      _pickImageFile = File(pickImage.path);
    });

    widget.onPickImage(
        _pickImageFile!); // Call the provided callback function with the picked image file
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.amber,
          foregroundImage:
              _pickImageFile != null ? FileImage(_pickImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        )
      ],
    );
  }
}
