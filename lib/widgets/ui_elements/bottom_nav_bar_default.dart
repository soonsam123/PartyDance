import 'package:flutter/material.dart';

class BottomNavBarDefault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(selectedItemColor: Colors.black, items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Events')),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite), title: Text('Favorites')),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile')),
    ]);
  }
}
