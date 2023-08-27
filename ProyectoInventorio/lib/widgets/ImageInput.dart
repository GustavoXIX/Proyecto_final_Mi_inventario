import 'dart:io';
import 'package:flutter/material.dart';
import '../Imports/import.dart';

class ImageInput extends StatefulWidget {
  final Function(File?) onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    final File pickedImage = File(imageFile.path);
    setState(() {
      _storedImage = pickedImage;
    });
    widget.onSelectImage(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _takePicture,
      child: Container(
        height: 180,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            if (_storedImage != null)
              Image.file(
                _storedImage!,
                fit: BoxFit.contain,
                width: double.infinity,
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
