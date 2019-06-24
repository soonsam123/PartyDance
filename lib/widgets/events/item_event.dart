import 'package:flutter/material.dart';

class ItemEvent extends StatelessWidget {
  final Map<String, dynamic> _event;
  final int _index;

  ItemEvent(this._event, this._index);

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(children: <Widget>[
      Image.asset(_event['image']),
      Text(_event['name'])
    ],),);
  }
}
