import 'package:cracker_app/+widgets/marker_details.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MarkerTile extends StatelessWidget {
  final _biggerFont = TextStyle(fontSize: 18.0);
  final marker;
  final Position userPosition;

  MarkerTile(this.marker, this.userPosition);

  String _getLabel() {
    final double lat1 = marker['latitude'];
    final double lon1 = marker['longitude'];
    String positionLabel = "";

    if (userPosition != null) {
      final double lat2 = userPosition.latitude;
      final double lon2 = userPosition.longitude;

      positionLabel =
          Geolocator.distanceBetween(lat1, lon1, lat2, lon2).toString();
    }

    return positionLabel;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MarkerDetails(marker, userPosition);
          }),
        );
      },
      title: Text(
        marker['english']['name'],
        style: _biggerFont,
      ),
      subtitle: Text(
        _getLabel(),
        style: _biggerFont,
      ),
    );
  }
}
