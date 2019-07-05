import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../widgets/events/item_event_big.dart';
import '../scoped_models/main.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';

class EventPage extends StatefulWidget {
  final MainModel model;

  EventPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _EventPageState();
  }
}

class _EventPageState extends State<EventPage> {
  Widget content;
  bool successfulResponse = true;

  @override
  void initState() {
    super.initState();
    widget.model
        .fetchEvents()
        .then((http.Response response) => _handleResponse(response));
  }

  @override
  Widget build(BuildContext context) {
    print('events: rerun Build');
    return Scaffold(
      body: _buildContent(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        setContent(model);
        return RefreshIndicator(
          child: content,
          onRefresh: model.fetchEvents,
        );
      },
    );
  }

  void setContent(MainModel model) {
    if (successfulResponse) {
      if (model.isLoading) {
        content = _buildProgressBar();
      } else if (!model.isLoading && model.events.length == 0) {
        content = Center(
          child: Text(Strings.msgNoEventsFound),
        );
      } else {
        content = _buildListView(model);
      }
    }
  }

  Center _buildProgressBar() => Center(child: CircularProgressIndicator());

  Widget _buildListView(MainModel model) {
    return Center(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ItemEventBig(model.events[index], index);
        },
        itemCount: model.events.length,
      ),
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

  void _handleResponse(http.Response response) {
    if (response != null) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        successfulResponse = true;
      } else {
        successfulResponse = false;
        setState(() {
          content = Center(
            child: Image.asset(Constants.imgServerError),
          );
        });
      }
    } else {
      successfulResponse = false;
      setState(() {
        content = Center(
          child: Image.asset(Constants.imgNoInternet),
        );
      });
    }
  }
}
