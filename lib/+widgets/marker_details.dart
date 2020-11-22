import 'package:flutter/material.dart';

class MarkerDetails extends StatelessWidget {
  final marker;

  const MarkerDetails(this.marker);

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
          Text(marker['polish']['description'])
        ],
      ),
    );
  }
}
