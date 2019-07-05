import 'package:flutter/material.dart';

class Event {
  final String id;
  final String name;
  final String location;
  final String date;
  final String image;
  final String userEmail;
  final bool isFavorite;

  Event({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.date,
    @required this.image,
    @required this.userEmail,
    this.isFavorite = false
  });
}
