import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:my_favorite_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      image: image,
      location: null,
      title: '',
    );

    _items.add(newPlace);
    notifyListeners();
  }
}
