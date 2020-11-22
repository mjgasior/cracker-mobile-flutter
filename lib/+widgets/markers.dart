import 'package:cracker_app/+widgets/marker_tile.dart';
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
  @override
  _MarkersState createState() => _MarkersState();
}

class _MarkersState extends State<Markers> {
  Position userLocation;

  Widget _buildRow(dynamic marker) {
    return MarkerTile(marker);
  }

  /*
  export function getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    const earthRadiusInKm = 6371;
    const deltaLatitude = degreesToRadians(lat2 - lat1);
    const deltaLongitude = degreesToRadians(lon2 - lon1);

    const a =
      Math.sin(deltaLatitude / 2) * Math.sin(deltaLatitude / 2) +
      Math.cos(degreesToRadians(lat1)) *
        Math.cos(degreesToRadians(lat2)) *
        Math.sin(deltaLongitude / 2) *
        Math.sin(deltaLongitude / 2);

    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    const distanceInKm = earthRadiusInKm * c;

    return distanceInKm;
  }
   */

  @override
  void initState() {
    super.initState();
    print("This is here");
    Geolocator.getPositionStream(timeInterval: 1000)
        .listen((Position position) {
      setState(() {
        userLocation = position;
      });
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
    });
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
          return Text('Loading');
        }

        List markers = result.data['markers'];
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
