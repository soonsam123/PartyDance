import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            _buildProfilePhoto(),
            _buildUserInfo(),
          ],
        ),
      ),
      margin: EdgeInsets.all(20.0),
    );
  }

  Widget _buildProfilePhoto() {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/ballerina.png'),
      radius: 50.0,
    );
  }

  Widget _buildUserInfo() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          margin: EdgeInsets.only(left: 20.0),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.authenticatedUser.email,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Anápolis, Brasil',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                Text('Professor')
              ],
            ),
          ),
        );
      },
    );
  }
}
