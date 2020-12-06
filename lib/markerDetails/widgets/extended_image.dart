import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

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
            child: PinchZoom(
              image: Image.network(
                url,
                headers: {'Authorization': 'Bearer $accessToken'},
              ),
              zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
              resetDuration: const Duration(milliseconds: 10000),
              maxScale: 2.5,
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
