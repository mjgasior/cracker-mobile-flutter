import 'package:cracker_app/markerDetails/widgets/marker_image.dart';
import 'package:cracker_app/markerDetails/widgets/marker_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MarkerDetails extends StatelessWidget {
  final marker;
  final Position userPosition;
  final String accessToken;

  const MarkerDetails(this.marker, this.userPosition, this.accessToken);

  String _getCurrentLocale(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    final locale = currentLocale.toLanguageTag() == 'pl' ? 'polish' : 'english';
    return locale;
  }

  @override
  Widget build(BuildContext context) {
    final imageFilename = marker['imageFilename'];
    final locale = _getCurrentLocale(context);
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MarkerImage(imageFilename, accessToken),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(marker[locale]['name'],
                    style: TextStyle(fontSize: 30)),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(marker[locale]['description'],
                    style: TextStyle(fontSize: 16)),
              ),
              MarkerMap(marker, userPosition)
            ],
          ),
        ));
  }
}
