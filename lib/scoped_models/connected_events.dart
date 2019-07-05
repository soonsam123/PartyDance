import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/event.dart';
import '../models/user.dart';
import '../utils/constants.dart';
import '../utils/strings.dart';

mixin ConnectedEvents on Model {
  User _authenticatedUser;
  bool _isLoading = false;
}

mixin EventModel on ConnectedEvents {
  List<Event> _events = [];
  String _selectedEventId;

  List<Event> get events {
    return _events;
  }

  List<Event> get favoriteEvents {
    return _events.where((Event event) => event.isFavorite).toList();
  }

  List<Event> get currentUserEvents {
    return _events
        .where((Event event) => event.userEmail == _authenticatedUser.email)
        .toList();
  }

  Event get selectedEvent {
    if (_selectedEventId != null) {
      return _events.firstWhere((Event event) {
        return event.id == _selectedEventId;
      });
    }
    return null;
  }

  int get selectedEventIndex {
    return _events.indexWhere((Event event) {
      return event.id == _selectedEventId;
    });
  }

  void selectEvent(String eventId) {
    _selectedEventId = eventId;
  }

  Future<http.Response> addEvent(Event newEvent) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> addEventData = {
      'name': newEvent.name,
      'location': newEvent.location,
      'date': newEvent.date,
      'image':
          "https://secure.meetupstatic.com/photos/event/1/2/2/b/600_435124651.jpeg",
      'userEmail': newEvent.userEmail,
      'isFavorite': newEvent.isFavorite
    };

    try {
      final http.Response response = await http.post(
          Constants.baseUrl + Constants.eventsJson,
          body: jsonEncode(addEventData));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('New event added: ' + response.body);
        Event newEventWithId = Event(
            id: response.body,
            name: newEvent.name,
            location: newEvent.location,
            date: newEvent.date,
            image:
                "https://secure.meetupstatic.com/photos/event/1/2/2/b/600_435124651.jpeg",
            userEmail: newEvent.userEmail);
        _events.add(newEventWithId);
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
      return response;
    } catch (error) {
      print(error.toString());
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<http.Response> fetchEvents() async {
    _isLoading = true;
    print('fetchEvents: ' + _isLoading.toString());
    notifyListeners();
    try {
      http.Response response =
          await http.get(Constants.baseUrl + Constants.eventsJson);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Event> fetchedEvents = [];
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        responseData?.forEach((String eventId, dynamic eventData) {
          final Event singleEvent = Event(
              id: eventId,
              name: eventData[Strings.name],
              location: eventData[Strings.location],
              date: eventData[Strings.date],
              image: eventData[Strings.image],
              userEmail: eventData[Strings.userEmail],
              isFavorite: eventData[Strings.isFavorite]);
          fetchedEvents.add(singleEvent);
        });
        _events = fetchedEvents;
        _isLoading = false;
        print('fetchEvents: ' + _isLoading.toString());
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        print('something bad happened');
      }
      return response;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print(error.toString());
      return null;
    }
  }

  void toggleFavorite() async {
    final bool isCurrentlyFavorite = _events[selectedEventIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Event newEvent = Event(
        id: _events[selectedEventIndex].id,
        name: _events[selectedEventIndex].name,
        location: _events[selectedEventIndex].location,
        date: _events[selectedEventIndex].date,
        userEmail: _events[selectedEventIndex].userEmail,
        image: _events[selectedEventIndex].image,
        isFavorite: newFavoriteStatus);

    final Map<String, dynamic> eventData = {
      'name': _events[selectedEventIndex].name,
      'location': _events[selectedEventIndex].location,
      'date': _events[selectedEventIndex].date,
      'userEmail': _events[selectedEventIndex].userEmail,
      'image': _events[selectedEventIndex].image,
      'isFavorite': newFavoriteStatus
    };

    try {
      http.Response response = await http.put(
          Constants.baseUrl +
              "events/${_events[selectedEventIndex].id}.json",
          body: jsonEncode(eventData));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
      } else {
        print('toggleFavorite: server error');
      }
    } catch (error) {
      print(error.toString());
    }

    _events[selectedEventIndex] = newEvent;
    _selectedEventId = null;
    notifyListeners();
  }

  Future<Null> deleteEvent() async {
    http.Response response = await http.delete(
        Constants.baseUrl + "events/${_events[selectedEventIndex].id}.json");
    _selectedEventId = null;
  }
}

mixin UserModel on ConnectedEvents {
  void login(String email, String password) {
    _authenticatedUser = User(email: email, password: password);
  }

  void logout() {
    _authenticatedUser = null;
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }
}

mixin UtilityModel on ConnectedEvents {
  bool get isLoading {
    return _isLoading;
  }
}
