import 'package:flutter/material.dart';

import '../models/event.dart';

class DetailEventPage extends StatelessWidget {
  final Event currentEvent;

  DetailEventPage(this.currentEvent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCollapsingToolBar(),
    );
  }

  NestedScrollView _buildCollapsingToolBar() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  currentEvent.name,
                  style: TextStyle(fontSize: 16.0, shadows: <Shadow>[
                    Shadow(
                        color: Colors.white,
                        offset: Offset(2.0, 1.0),
                        blurRadius: 2.0)
                  ]),
                ),
                background: Image.asset(currentEvent.image),
              ),
            )
          ];
        },
        body: _buildContent());
  }

  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(currentEvent.location, style: TextStyle(fontSize: 15.0),),
          Text(currentEvent.data, style: TextStyle(fontSize: 15.0),),
        ],
      ),
    );
  }
}
