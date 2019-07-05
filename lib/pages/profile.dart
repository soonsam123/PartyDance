import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../widgets/events/item_event_small.dart';

class ProfilePage extends StatefulWidget {
  final MainModel model;

  ProfilePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return _buildContent(model);
    });
  }

  Widget _buildContent(MainModel model) {
    return Column(
      children: <Widget>[_buildUserInfo(model), _buildListView(model)],
    );
  }

  Container _buildUserInfo(MainModel model) {
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            _buildProfilePhoto(),
            _buildUserTextInfo(model),
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

  Widget _buildUserTextInfo(MainModel model) {
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
  }

  Widget _buildListView(MainModel model) {
    Widget content = Expanded(
        child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildItemEvent(model, index);
      },
      itemCount: model.currentUserEvents.length,
    ));
    if (model.isLoading) {
      content = Center(child: CircularProgressIndicator());
    }
    return content;
  }

  Widget _buildItemEvent(MainModel model, int index) {
    return Dismissible(
      key: Key(model.currentUserEvents[index].id),
      child: ItemEventSmall(model.currentUserEvents[index]),
      background: _buildDismissibleBg(),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          model.selectEvent(model.currentUserEvents[index].id);
          model.deleteEvent();
        }
      },
    );
  }

  Container _buildDismissibleBg() {
    return Container(
      color: Colors.red,
      child: Center(
        child: ListTileTheme(
          child: ListTile(
            trailing: Icon(Icons.delete),
          ),
          iconColor: Colors.white,
        ),
      ),
    );
  }
}
