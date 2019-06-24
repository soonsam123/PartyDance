import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './pages/events.dart';
import './pages/auth.dart';
import './pages/add_event.dart';
import './pages/home.dart';
import './pages/detail_event.dart';

void main() {
//  debugPaintPointersEnabled = true;
//  debugPaintSizeEnabled = true;
//  debugPaintBaselinesEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> events = [
    {
      'name': 'Noite Dançante no Villa Sertaneja',
      'location': 'Villa Sertaneja - Anápolis',
      'data': 'Quarta Feira, 21:00 às 04:00',
      'image': 'assets/dance_thumb.jpeg'
    },
    {
      'name': '2 Noite Dançante no Villa Sertaneja',
      'location': 'Villa Sertaneja - Anápolis',
      'data': 'Quarta Feira, 21:00 às 04:00',
      'image': 'assets/dance_thumb.jpeg'
    },
    {
      'name': '3 Noite Dançante no Villa Sertaneja',
      'location': 'Villa Sertaneja - Anápolis',
      'data': 'Quarta Feira, 21:00 às 04:00',
      'image': 'assets/dance_thumb.jpeg'
    },
    {
      'name': '4 Noite Dançante no Villa Sertaneja',
      'location': 'Villa Sertaneja - Anápolis',
      'data': 'Quarta Feira, 21:00 às 04:00',
      'image': 'assets/dance_thumb.jpeg'
    },
    {
      'name': '5 Noite Dançante no Villa Sertaneja',
      'location': 'Villa Sertaneja - Anápolis',
      'data': 'Quarta Feira, 21:00 às 04:00',
      'image': 'assets/dance_thumb.jpeg'
    },
  ];
  List<Map<String, dynamic>> favoriteEvents = [];

  void _addEvent(Map<String, dynamic> newEvent) {
    setState(() {
      events.add(newEvent);
    });
  }

  void _favoriteEvent(int index) {
    setState(() {
      favoriteEvents.add(events[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartyDance',
      theme: ThemeData(
          accentColor: Colors.greenAccent,
          primaryColor: Colors.white,
          buttonColor: Colors.greenAccent),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) =>
            AuthPage(),
        '/home': (BuildContext context) =>
            HomePage(events, favoriteEvents, _favoriteEvent),
        '/events': (BuildContext context) => EventPage(events, _favoriteEvent),
        '/add_event': (BuildContext context) => AddEventPage(_addEvent),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'event') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (context) => DetailEventPage(events[index]));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                AuthPage()); // Should change to 404
      },
    );
  }
}
