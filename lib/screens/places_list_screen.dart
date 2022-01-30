import 'package:flutter/material.dart';
import 'package:places/provisers/great_places.dart';
import 'package:places/screens/place_details.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                        ? const Center(
                            child: Text(
                            'No places yet',
                            style: TextStyle(fontSize: 20),
                          ))
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (_, i) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[i].image),
                                ),
                                title: Text(greatPlaces.items[i].title),
                                subtitle: Text(greatPlaces.items[i].location.latitude.toString()),
                                onTap: () {
                                  Navigator.of(context).pushNamed(PlaceDetails.routeName,arguments:greatPlaces.items[i].id);
                                },
                              );
                            },
                          )),
      ),
    );
  }
}
