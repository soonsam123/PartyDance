import 'package:flutter/material.dart';

import '../../models/event.dart';

class ItemEventSmall extends StatelessWidget {
  final Event _event;

  ItemEventSmall(this._event);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(_event.name),
        subtitle: Text(_event.location),
        leading: CircleAvatar(
          backgroundImage: AssetImage(_event.image),
        ));
  }
}
