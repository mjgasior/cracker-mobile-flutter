import 'package:cracker_app/+widgets/marker_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MarkerDetails extends StatelessWidget {
  final marker;
  final Position userPosition;

  const MarkerDetails(this.marker, this.userPosition);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FlatButton(
            child: Text('Go back!'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(marker['polish']['name']),
          Text(marker['polish']['description']),
          Text(marker['english']['name']),
          Text(marker['english']['description']),
          MarkerMap(marker, userPosition)
        ],
      ),
    );
  }
}
