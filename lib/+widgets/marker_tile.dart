import 'package:cracker_app/+widgets/marker_details.dart';
import 'package:flutter/material.dart';

class MarkerTile extends StatelessWidget {
  final marker;
  final _biggerFont = TextStyle(fontSize: 18.0);

  MarkerTile(this.marker);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print('${marker['polish']['name']} was tapped!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return MarkerDetails(marker);
          }),
        );
      },
      title: Text(
        marker['polish']['name'],
        style: _biggerFont,
      ),
    );
  }
}
