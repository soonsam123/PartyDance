import 'package:flutter/material.dart';

class ItemEventSmall extends StatelessWidget {
  final Map<String, dynamic> _event;

  ItemEventSmall(this._event);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(_event['name']),
        subtitle: Text(_event['location']),
        leading: CircleAvatar(
          backgroundImage: AssetImage(_event['image']),
        ));
  }
}
