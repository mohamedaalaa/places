import 'package:flutter/material.dart';
import 'package:places/provisers/great_places.dart';
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
      body: Consumer<GreatPlaces>(
          builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
              ? const Text('No places yet')
              : ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(greatPlaces.items[i].image),
                      ),
                      title: Text(greatPlaces.items[i].title),
                      onTap: () {},
                    );
                  },
                )),
    );
  }
}
