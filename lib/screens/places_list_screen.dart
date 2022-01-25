import 'package:flutter/material.dart';
import 'package:my_favorite_places/providers/great_places.dart';
import 'package:my_favorite_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus lugares'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('Nenhum local cadastrado'),
                ),
                builder: (BuildContext context, GreatPlaces greatPlaces,
                        Widget? child) =>
                    greatPlaces.itemsCount == 0
                        ? child!
                        : ListView.builder(
                            itemCount: greatPlaces.itemsCount,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  greatPlaces.itemByIndex(index).image,
                                ),
                              ),
                              title: Text(greatPlaces.itemByIndex(index).title),
                              subtitle: Text(
                                greatPlaces
                                    .itemByIndex(index)
                                    .location!
                                    .address!,
                              ),
                              onTap: () {},
                            ),
                          ),
              ),
      ),
    );
  }
}
