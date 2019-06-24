import 'package:flutter/material.dart';

import '../widgets/ui_elements/bottom_nav_bar_default.dart';
import '../widgets/events/item_event.dart';

class EventPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EventPageState();
  }
}

class _EventPageState extends State<EventPage> {
  List<Map<String, dynamic>> events = [
    {
      'name': 'Noite Dançante no Villa Sertaneja',
      'local': 'Anápolis',
      'data': 'Quarta Feira, 21:00 às 04:00',
      'image': 'assets/dance_thumb.jpeg'
    },
    {
      'name': 'Noite Dançante no Villa Sertaneja',
      'local': 'Anápolis',
      'data': 'Quarta Feira, 21:00 às 04:00',
      'image': 'assets/dance_thumb.jpeg'
    },
    {
      'name': 'Noite Dançante no Villa Sertaneja',
      'local': 'Anápolis',
      'data': 'Quarta Feira, 21:00 às 04:00',
      'image': 'assets/dance_thumb.jpeg'
    }
  ];

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Events'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ItemEvent(events[index], index);
          },
          itemCount: events.length,
        ),
      ),
      bottomNavigationBar: BottomNavBarDefault(),
    );
  }
}
