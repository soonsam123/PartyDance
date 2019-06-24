import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './pages/events.dart';
import './pages/auth.dart';

void main() {
//  debugPaintPointersEnabled = true;
//  debugPaintSizeEnabled = true;
//  debugPaintBaselinesEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartyDance',
      theme: ThemeData(
          accentColor: Colors.greenAccent, primaryColor: Colors.white, buttonColor: Colors.greenAccent),
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => EventPage(), // Change to AuthPage later
        '/events': (BuildContext context) => EventPage(),
      },
    );
  }
}
