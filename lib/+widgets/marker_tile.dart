import 'package:cracker_app/+widgets/marker_details.dart';
import 'package:flutter/material.dart';

class MarkerTile extends StatelessWidget {
  final _biggerFont = TextStyle(fontSize: 18.0);
  final marker;

  MarkerTile(this.marker);

  @override
  Widget build(BuildContext context) {
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
