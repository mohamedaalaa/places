import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/models/place.dart';
import 'package:places/provisers/great_places.dart';
import 'package:places/widgets/image_input.dart';
import 'package:places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add_place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  File? _storedImage;
  PlaceLocation? _placeLocation;
  final _titleController=TextEditingController();

  void _selectImage(File pickedFile){
    _storedImage=pickedFile;
  }

  void _selectPlace(double lat,double lng){
    _placeLocation=PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _storedImage == null || _placeLocation==null){
      return;
    }
    Provider.of<GreatPlaces>(context,listen: false).addPlace(_titleController.text, _storedImage!,_placeLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 10,),
                     ImageInput( selectImage: _selectImage,),
                    const SizedBox(height: 10,),
                     LocationInput(selectPlace:_selectPlace,)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed:_savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add place'),

          )
        ],
      ),
    );
  }
}
