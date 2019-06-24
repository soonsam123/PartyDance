import 'package:flutter/material.dart';

import './favorites.dart';
import './profile.dart';
import './events.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> events;
  final List<Map<String, dynamic>> favoriteEvents;
  final Function favoriteEvent;

  HomePage(this.events, this.favoriteEvents, this.favoriteEvent);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  final List<String> _appBarTitle = ['Events', 'Favorites', 'Profile'];

  @override
  void initState() {
    super.initState();
    _children.add(EventPage(widget.events, widget.favoriteEvent));
    _children.add(FavoritesPage(widget.favoriteEvents));
    _children.add(ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _children[_currentIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(_appBarTitle[_currentIndex]),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Events')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favorites')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile')),
        ]);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
