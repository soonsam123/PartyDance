import 'package:scoped_model/scoped_model.dart';

import '../models/event.dart';

mixin EventModel on Model {
  List<Event> _events = [];
  int _selectedProductIndex;

  List<Event> get events {
    return _events;
  }

  List<Event> get favoriteEvents {
    return _events.where((Event event) => event.isFavorite).toList();
  }

  Event get selectedEvent {
    if (_selectedProductIndex != null) {
      return _events[_selectedProductIndex];
    }
    return null;
  }

  void selectEvent(int currentIndex) {
    _selectedProductIndex = currentIndex;
  }

  void addEvent(Event newEvent) {
    _events.add(newEvent);
  }

  void toggleFavorite() {
    final bool isCurrentlyFavorite = _events[_selectedProductIndex].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Event newEvent = Event(
        name: _events[_selectedProductIndex].name,
        location: _events[_selectedProductIndex].location,
        data: _events[_selectedProductIndex].data,
        image: _events[_selectedProductIndex].image,
        isFavorite: newFavoriteStatus);
    _events[_selectedProductIndex] = newEvent;
    notifyListeners();
  }
}
