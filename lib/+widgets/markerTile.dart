import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final marker;

  const DetailScreen(this.marker);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('${marker['polish']['name']} was tapped!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

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
            return DetailScreen(marker);
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
