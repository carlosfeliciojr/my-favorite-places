import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_favorite_places/screens/map_screen.dart';
import 'package:my_favorite_places/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );

    if (selectedLocation == null) return;
    print(selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text('Localização não informada')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Localização atual'),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Selecione no mapa'),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}