import 'package:flutter/material.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

class ExtendedImage extends StatelessWidget {
  final String url;
  final String accessToken;

  const ExtendedImage(this.url, this.accessToken);

  @override
  Widget build2(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: PinchZoomImage(
              image: Image.network(
                url,
                headers: {'Authorization': 'Bearer $accessToken'},
              ),
              zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
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
