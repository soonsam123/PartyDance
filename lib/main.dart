import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/events.dart';
import './pages/auth.dart';
import './pages/add_event.dart';
import './pages/home.dart';
import './pages/detail_event.dart';
import './scoped_models/main.dart';
import './models/event.dart';

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
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: _buildMaterialApp(model),
    );
  }

  MaterialApp _buildMaterialApp(MainModel model) {
    return MaterialApp(
      title: 'PartyDance',
      theme: ThemeData(
          accentColor: Colors.greenAccent,
          primaryColor: Colors.white,
          buttonColor: Colors.greenAccent),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => AuthPage(),
        '/home': (BuildContext context) => HomePage(model),
        '/events': (BuildContext context) => EventPage(model),
        '/add_event': (BuildContext context) => AddEventPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'event') {
          final int index = int.parse(pathElements[2]);
          final Event currentEvent = model.events[index];
          return MaterialPageRoute<bool>(
              builder: (context) => DetailEventPage(currentEvent));
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
