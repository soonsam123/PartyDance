import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/event.dart';
import '../../scoped_models/main.dart';

class ItemEventBig extends StatelessWidget {
  final Event _event;
  final int _index;

  ItemEventBig(this._event, this._index);

  Widget _buildInfoText() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _event.name,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            _event.location,
          ),
          Text(
            _event.date,
          )
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    return Container(
        constraints: BoxConstraints.expand(height: 220),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_event.image),
            fit: BoxFit.cover,
          ),
        ),
        child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return _buildFavoriteIcon(model);
        }));
  }

  GestureDetector _buildFavoriteIcon(MainModel model) {
    return GestureDetector(
      onTap: () {
        model.selectEvent(model.events[_index].id);
        model.toggleFavorite();
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Icon(
              model.events[_index].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.white,
            ),
            top: 10.0,
            right: 10.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/event/' + _index.toString());
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildThumbnail(),
            _buildInfoText(),
          ],
        ),
      ),
    );
  }
}
