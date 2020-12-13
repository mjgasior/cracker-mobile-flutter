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
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(20.0),
              minScale: 0.1,
              maxScale: 3,
              child: Image.network(
                url,
                headers: {'Authorization': 'Bearer $accessToken'},
              ),
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
