import 'package:flutter/material.dart';

import '../widgets/events/item_event_small.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> _favoriteEvents;

  FavoritesPage(this._favoriteEvents);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ItemEventSmall(_favoriteEvents[index]),
        itemCount: _favoriteEvents.length,
      ),
    );
  }
}
