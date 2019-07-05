import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/events/item_event_small.dart';
import '../scoped_models/main.dart';
import '../utils/strings.dart';

class FavoritesPage extends StatefulWidget {
  final MainModel model;

  FavoritesPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _FavoritesPageState();
  }
}

class _FavoritesPageState extends State<FavoritesPage> {
  Widget content;

  _FavoritesPageState();

  @override
  void initState() {
    super.initState();
    widget.model.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }

  void _setContent(MainModel model) {
    content = Center(
      child: Text(Strings.msgNoFavoriteEventsFound),
    );

    if (model.isLoading) {
      content = Center(child: CircularProgressIndicator());
    } else if (!model.isLoading && model.favoriteEvents.length != 0) {
      content = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ItemEventSmall(model.favoriteEvents[index]);
        },
        itemCount: model.favoriteEvents.length,
      );
    }
  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      _setContent(model);
      return content;
    });

  }
}
