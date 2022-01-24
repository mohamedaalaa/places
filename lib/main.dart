import 'package:flutter/material.dart';
import 'package:places/provisers/great_places.dart';
import 'package:places/screens/add_place_screen.dart';
import 'package:places/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
        ),
        home:PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName:(ctx)=>AddPlaceScreen()
        },
      ),
    );
  }
}
