import 'package:flutter/material.dart';

class ExtendedImage extends StatelessWidget {
  final String url;
  final String accessToken;

  const ExtendedImage(this.url, this.accessToken);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              url,
              headers: {'Authorization': 'Bearer $accessToken'},
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
