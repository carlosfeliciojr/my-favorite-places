import 'package:flutter/material.dart';
import 'package:my_favorite_places/providers/great_places.dart';
import 'package:my_favorite_places/screens/place_form_screen.dart';
import 'package:my_favorite_places/utils/app_routes.dart';
import 'package:provider/provider.dart';
import './screens/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'My Favorite Places',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.placeForm: (context) => const PlaceFormScreen(),
        },
      ),
    );
  }
}
