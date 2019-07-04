import 'package:flutter/material.dart';

class Event {
  final String name;
  final String location;
  final String data;
  final String image;
  final bool isFavorite;

  Event({
    @required this.name,
    @required this.location,
    @required this.data,
    @required this.image,
    this.isFavorite = false
  });
}
