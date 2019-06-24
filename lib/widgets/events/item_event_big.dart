import 'package:flutter/material.dart';

class ItemEventBig extends StatelessWidget {
  final Map<String, dynamic> _event;
  final int _index;
  final Function _favoriteEvent;

  ItemEventBig(this._event, this._index, this._favoriteEvent);

  Widget _buildInfoText() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _event['name'],
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            _event['location'],
          ),
          Text(
            _event['data'],
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
            image: AssetImage(_event['image']),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            _favoriteEvent(_index);
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
                top: 10.0,
                right: 10.0,
              ),
            ],
          ),
        ));
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
