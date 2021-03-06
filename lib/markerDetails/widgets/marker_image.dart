import 'package:cracker_app/markerDetails/widgets/extended_image.dart';
import 'package:flutter/material.dart';

class MarkerImage extends StatelessWidget {
  final String imageFilename;
  final String accessToken;

  MarkerImage(this.imageFilename, this.accessToken);

  bool _hasAccessToken() {
    return accessToken != null && accessToken != "";
  }

  Widget _buildRegular(BuildContext context) {
    if (imageFilename == null) {
      return Container();
    }

    String url = 'https://cracker.red/images/$imageFilename';
    double imageSize = 200;
    if (!_hasAccessToken()) {
      imageSize = 70;
      url += '?w=30&h=30';
    }

    return GestureDetector(
        child: Hero(
            tag: 'imageHero',
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(254, 203, 0, 1), width: 4.0),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    url,
                    headers: {'Authorization': 'Bearer $accessToken'},
                  ),
                ),
              ),
            )),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ExtendedImage(url, accessToken);
          }));
        });
  }

  @override
  Widget build(BuildContext context) {
    if (imageFilename == null) {
      return Container();
    }
    return _buildRegular(context);
  }
}
