import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/event.dart';
import '../scoped_models/main.dart';

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
        return RaisedButton(
          onPressed: () {
            _submitForm(model);
          },
          child: Text('Add Event'),
          textColor: Colors.white,
        );
      },
    );
  }

  void _submitForm(MainModel model) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final Event newEvent = Event(
          name: _eventData['name'],
          location: _eventData['location'],
          data: _eventData['data'],
          image: _eventData['image']);
      model.addEvent(newEvent);
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
