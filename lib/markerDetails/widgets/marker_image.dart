import 'package:flutter/material.dart';

class MarkerImage extends StatelessWidget {
  final String imageFilename;

  MarkerImage(this.imageFilename);

  @override
  Widget build(BuildContext context) {
    if (imageFilename == null) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 4.0),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage('https://cracker.red/images/$imageFilename'),
        ),
      ),
    );
  }
}
