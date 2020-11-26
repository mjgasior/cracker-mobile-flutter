import 'package:cracker_app/markerDetails/widgets/marker_image.dart';
import 'package:cracker_app/markerDetails/widgets/marker_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MarkerDetails extends StatelessWidget {
  final marker;
  final Position userPosition;

  const MarkerDetails(this.marker, this.userPosition);

  @override
  Widget build(BuildContext context) {
    final imageFilename = marker['imageFilename'];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          MarkerImage(imageFilename),
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
