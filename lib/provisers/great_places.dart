

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/models/place.dart';

class GreatPlaces with ChangeNotifier{
  final List<Place> _items=[];

  List<Place> get items{
    return _items;
  }

  void addPlace(String title,File image){
    final newPlace=Place(id: DateTime.now().toString(), title: title, image: image,);
    _items.add(newPlace);
    notifyListeners();
  }
}