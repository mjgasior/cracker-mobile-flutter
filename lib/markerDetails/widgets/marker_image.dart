import 'package:flutter/material.dart';

class MarkerImage extends StatelessWidget {
  final String imageFilename;
  final String accessToken;

  MarkerImage(this.imageFilename, this.accessToken);

  bool _hasAccessToken() {
    return accessToken != null && accessToken != "";
  }

  Widget _buildRegular() {
    if (imageFilename == null) {
      return Container();
    }

    String url = 'https://cracker.red/images/$imageFilename';
    double imageSize = 200;
    if (!_hasAccessToken()) {
      imageSize = 70;
      url += '?w=30&h=30';
    }

    return Container(
      margin: const EdgeInsets.all(10.0),
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(254, 203, 0, 1), width: 4.0),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            url,
            headers: {'Authorization': 'Bearer $accessToken'},
          ),
        ),
      ),
    );
  }

  @override
  Widget build2(BuildContext context) {
    if (imageFilename == null) {
      return Container();
    }
    return _buildRegular();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
        tag: 'imageHero',
        child: Image.network(
          'https://picsum.photos/250?image=9',
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return DetailScreen();
        }));
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              'https://picsum.photos/250?image=9',
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
