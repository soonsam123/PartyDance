import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/events/item_event_big.dart';
import '../scoped_models/main.dart';

class EventPage extends StatefulWidget {
  EventPage();

  @override
  State<StatefulWidget> createState() {
    return _EventPageState();
  }
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListView(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildListView() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Center(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ItemEventBig(model.events[index], index);
            },
            itemCount: model.events.length,
          ),
        );
      },
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _navigateToAddEventPage();
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      elevation: 8.0,
    );
  }

  void _navigateToAddEventPage() {
    Navigator.of(context).pushNamed('/add_event');
  }
}
