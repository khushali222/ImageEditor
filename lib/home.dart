
import 'dart:io';

import 'package:flutter/material.dart';


import 'package:image_picker/image_picker.dart';

import 'image_editor.dart';



class ImageEditorScreen extends StatefulWidget {
  @override
  _ImageEditorScreenState createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends State<ImageEditorScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Editor Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null) ...[
              Image.file(_imageFile!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageEditor(
                        image: _imageFile!,
                      ),
                    ),
                  );
                },
                child: Text('Edit Image'),
              ),
            ] else ...[
              Text('No image selected'),
              SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}