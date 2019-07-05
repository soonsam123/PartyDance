import 'package:flutter/material.dart';

import './favorites.dart';
import './profile.dart';
import './events.dart';
import '../scoped_models/main.dart';
import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  final MainModel model;

  HomePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  final List<String> _appBarTitle = ['Events', 'Favorites', 'Profile'];
  final List<Icon> _appBarIcon = [
    Icon(Icons.search),
    Icon(Icons.search),
    Icon(Icons.more_vert)
  ];

  @override
  void initState() {
    super.initState();
    _children.add(EventPage(widget.model));
    _children.add(FavoritesPage(widget.model));
    _children.add(ProfilePage(widget.model));
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
        _buildAppBarActionBtn()
      ],
    );
  }

  Widget _buildAppBarActionBtn() {
    if (_currentIndex == 2) {
      return _buildPopupMenuBtn();
    } else {
      return IconButton(icon: Icon(Icons.search), onPressed: () {});
    }
  }

  PopupMenuButton<String> _buildPopupMenuBtn() {
    return PopupMenuButton<String>(
      onSelected: choiceAction,
      itemBuilder: (BuildContext context) {
        return Constants.choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
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

  void choiceAction(String choice) {
    if (choice == Constants.settings) {
      print('Settings');
    } else if (choice == Constants.signOut) {
      _logout();
    }
  }

  void _logout() {
    widget.model.logout();
    Navigator.of(context).pushReplacementNamed('/');
  }
}
