import 'package:flutter/material.dart';

class MarkerImage extends StatelessWidget {
  final String imageFilename;
  final String accessToken;

  MarkerImage(this.imageFilename, this.accessToken);

  Widget _buildRegular() {
    if (imageFilename == null) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 4.0),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            'https://cracker.red/images/$imageFilename',
            headers: {'Authorization': 'Bearer $accessToken'},
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageFilename == null) {
      return Container();
    }
    return _buildRegular();
  }
}
