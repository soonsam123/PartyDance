import 'package:flutter/material.dart';

import '../widgets/events/item_event_big.dart';

class EventPage extends StatefulWidget {
  final List<Map<String, dynamic>> events;
  final Function favoriteEvent;

  EventPage(this.events, this.favoriteEvent);

  @override
  State<StatefulWidget> createState() {
    return _EventPageState();
  }
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ItemEventBig(widget.events[index], index, widget.favoriteEvent);
          },
          itemCount: widget.events.length,
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _addEvent();
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      elevation: 8.0,
    );
  }

  void _addEvent() {
    Navigator.of(context).pushNamed('/add_event');
  }
}
