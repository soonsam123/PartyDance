import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/events/item_event_small.dart';
import '../scoped_models/main.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return _buildListView(model);
      }),
    );
  }

  Widget _buildListView(MainModel model) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ItemEventSmall(model.favoriteEvents[index]);
      },
      itemCount: model.favoriteEvents.length,
    );
  }
}
