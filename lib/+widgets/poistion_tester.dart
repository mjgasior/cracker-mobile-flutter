import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionTester extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed:  () async {
            Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            print(position);
          },
          child: Text('Get position!'),
        ),
        Text("Test position"),
      ],
    );
  }
}
