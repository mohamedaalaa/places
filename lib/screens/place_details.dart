import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/provisers/great_places.dart';
import 'package:places/screens/user_location.dart';
import 'package:provider/provider.dart';

class PlaceDetails extends StatelessWidget {
  static const String routeName = '/place_details';

  const PlaceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final place = Provider.of<GreatPlaces>(context,listen: false).findPlaceById(id);
    return Scaffold(
        appBar: AppBar(
          title: Text(place.id),
        ),
        body: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        place.location.latitude, place.location.longitude)),
                  markers: {
                    Marker(
                      markerId: const MarkerId('m1'),
                      position: LatLng(place.location.latitude,place.location.longitude),
                    )
                  },
                mapType: MapType.normal,
              ),
            ),
            const SizedBox(),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                      builder: (context) => UserLocation(
                          isSelecting: true,
                          latitude: place.location.latitude,
                          longitude: place.location.longitude)));
                },
                icon: const Icon(Icons.map),
                label: const Text('Show On Map'))
          ],
        ));
  }
}
