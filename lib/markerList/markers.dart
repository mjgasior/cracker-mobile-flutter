import 'dart:async';

import 'package:cracker_app/markerList/marker_tile.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String readMarkers = """
    {
    markers {
      _id
      latitude
      longitude
      imageFilename
      polish {
        name
        description
      }
      english {
        name
        description
      }
    }
  }
""";

class Markers extends StatefulWidget {
  final String accessToken;

  const Markers(this.accessToken);

  @override
  _MarkersState createState() => _MarkersState();
}

class _MarkersState extends State<Markers> {
  Position userLocation;
  StreamSubscription<Position> positionStream;

  Widget _buildRow(dynamic marker) {
    return MarkerTile(marker, userLocation, widget.accessToken);
  }

  double _getDistance(marker, userPosition) {
    final double lat1 = marker['latitude'];
    final double lon1 = marker['longitude'];

    if (userPosition != null) {
      final double lat2 = userPosition.latitude;
      final double lon2 = userPosition.longitude;

      return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    }

    return null;
  }

  Iterable _processMarkers(List markers) {
    if (markers.length > 0) {
      return markers.map((item) {
        item['distance'] = _getDistance(item, this.userLocation);
        return item;
      }).toList()
        ..sort((a, b) => a['distance'].compareTo(b['distance']));
    }
    return markers;
  }

  @override
  void initState() {
    super.initState();

    // ignore: cancel_subscriptions
    StreamSubscription<Position> geolocatorStream =
        Geolocator.getPositionStream(timeInterval: 10000)
            .listen((Position position) {
      if (mounted) {
        setState(() {
          userLocation = position;
        });
      }
    });

    setState(() {
      positionStream = geolocatorStream;
    });
  }

  @override
  void deactivate() {
    positionStream.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(readMarkers),
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Center(child: CircularProgressIndicator());
        }

        List markers = _processMarkers(result.data['markers']);
        return Expanded(
            child: ListView.builder(
                itemCount: markers.length,
                itemBuilder: (context, index) {
                  final marker = markers[index];
                  return _buildRow(marker);
                }));
      },
    );
  }
}
