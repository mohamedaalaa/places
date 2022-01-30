import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/helpers/db_helpers.dart';
import 'package:places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  void addPlace(String title, File image,PlaceLocation locationData) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image, location: locationData,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat':newPlace.location.latitude,
      'loc_lng':newPlace.location.longitude,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (element) => Place(
            id: element['id'],
            title: element['title'],
            image: File(
              element['image'],
            ),
            location: PlaceLocation(longitude:element['loc_lat'], latitude:element['loc_lng']),
          ),
        )
        .toList();
    notifyListeners();
  }

  Place  findPlaceById(String id){
    return _items.firstWhere((place) => place.id==id);
  }
}
