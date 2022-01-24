import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {

  final Function(File pickedFile) selectImage;

   const ImageInput( {Key? key,required this.selectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;



  Future<void> _takePhoto() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if(imageFile==null){
      return;
    }
    setState(() {
      _storedImage=File(imageFile.path);
    });
    final appDir=await getApplicationDocumentsDirectory();
    final fileName=basename(imageFile.path);
    final savedImage=await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.selectImage(savedImage);
    //_storedImage=_imageFile as File?;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextButton.icon(
          onPressed: () {
            _takePhoto();
          },
          icon: const Icon(Icons.camera_alt),
          label: const Text(
            'Take a photo',
            style: TextStyle(color: Colors.deepPurpleAccent),
          ),
        ))
      ],
    );
  }
}
