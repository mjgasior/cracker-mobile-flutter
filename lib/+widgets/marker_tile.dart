import 'package:cracker_app/+widgets/marker_details.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MarkerTile extends StatefulWidget {
  final marker;

  MarkerTile(this.marker);

  @override
  _MarkerTileState createState() => _MarkerTileState();
}

class _MarkerTileState extends State<MarkerTile> {
  final _biggerFont = TextStyle(fontSize: 18.0);
  Position userLocation;

  @override
  void initState() {
    super.initState();
    print("This is here");
    Geolocator.getPositionStream(timeInterval: 1000)
        .listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final marker = widget.marker;
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MarkerDetails(marker);
          }),
        );
      },
      title: Text(
        marker['english']['name'],
        style: _biggerFont,
      ),
      subtitle: Text(
        marker['english']['name'],
        style: _biggerFont,
      ),
    );
  }
}
