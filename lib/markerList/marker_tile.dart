import 'package:cracker_app/markerDetails/marker_details.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MarkerTile extends StatelessWidget {
  final _biggerFont = TextStyle(fontSize: 18.0);
  final marker;
  final Position userPosition;
  final String accessToken;

  MarkerTile(this.marker, this.userPosition, this.accessToken);

  String _getLabel() {
    String positionLabel = "";

    if (marker['distance'] != null) {
      positionLabel = "${marker['distance'].toStringAsFixed(0)} m";
    }

    return positionLabel;
  }

  String _getCurrentLocale(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    final locale = currentLocale.toLanguageTag() == 'pl' ? 'polish' : 'english';
    return locale;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MarkerDetails(marker, userPosition, accessToken);
          }),
        );
      },
      title: Text(
        marker[_getCurrentLocale(context)]['name'],
        style: _biggerFont,
      ),
      subtitle: Text(
        _getLabel(),
        style: _biggerFont,
      ),
    );
  }
}
