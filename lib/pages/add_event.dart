import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/event.dart';
import '../scoped_models/main.dart';
import '../utils/strings.dart';

class AddEventPage extends StatefulWidget {
  AddEventPage();

  @override
  State<StatefulWidget> createState() {
    return _AddEventPageState();
  }
}

class _AddEventPageState extends State<AddEventPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _eventData = {
    'name': null,
    'location': null,
    'data': null,
    'userEmail': null,
    'image': 'assets/dance_thumb.jpeg'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildNameField(),
            SizedBox(
              height: 10.0,
            ),
            _buildLocationField(),
            SizedBox(
              height: 10.0,
            ),
            _buildDateField(),
            SizedBox(
              height: 20.0,
            ),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      onSaved: (String value) {
        _eventData['name'] = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required Field';
        }
      },
    );
  }

  Widget _buildLocationField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Location'),
      onSaved: (String value) {
        _eventData['location'] = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required Field';
        }
      },
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Date'),
      onSaved: (String value) {
        _eventData['data'] = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required Field';
        }
      },
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = RaisedButton(
          onPressed: () {
            _submitForm(model);
          },
          child: Text('Add Event'),
          textColor: Colors.white,
        );
        if (model.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        }
        return content;
      },
    );
  }

  void _submitForm(MainModel model) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final Event newEvent = Event(
          id: null,
          name: _eventData['name'],
          location: _eventData['location'],
          date: _eventData['data'],
          userEmail: model.authenticatedUser?.email,
          image: _eventData['image']);
      model.addEvent(newEvent).then((http.Response response) {
        _handleResponse(response);
      });
    }
  }

  void _handleResponse(http.Response response) {
    if (response != null) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        _displayErrorDialog(
            message: Strings.errorServer +
                " Code: " +
                response.statusCode.toString());
      }
    } else {
      _displayErrorDialog(message: Strings.errorNoInternetConnection);
    }
  }

  void _displayErrorDialog({String message}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Strings.errorSomethingBad),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(Strings.ok))
            ],
          );
        });
  }
}
