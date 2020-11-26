import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerMap extends StatefulWidget {
  final marker;
  final Position userPosition;

  const MarkerMap(this.marker, this.userPosition);

  @override
  State<MarkerMap> createState() => MarkerMapState();
}

class MarkerMapState extends State<MarkerMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(widget.marker['latitude'], widget.marker['longitude']),
      zoom: 14.4746,
    );

    final markerPosition =
        LatLng(widget.marker['latitude'], widget.marker['longitude']);

    Set<Marker> markers = Set();
    markers.add(Marker(
        markerId: MarkerId(widget.marker['_id']), position: markerPosition));

    LatLng userPosition;
    if (widget.userPosition != null) {
      userPosition =
          LatLng(widget.userPosition.latitude, widget.userPosition.longitude);
      markers.add(Marker(markerId: MarkerId('user'), position: userPosition));
    }

    return Container(
        height: 200,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            if (userPosition != null) {
              controller.animateCamera(CameraUpdate.newLatLngBounds(
                  _getBounds(userPosition, markerPosition), 50));
            }

            _controller.complete(controller);
          },
          markers: markers,
        ));
  }

  LatLngBounds _getBounds(LatLng userPosition, LatLng markerPosition) {
    if (userPosition.latitude <= markerPosition.latitude) {
      return LatLngBounds(southwest: userPosition, northeast: markerPosition);
    }
    return LatLngBounds(southwest: markerPosition, northeast: userPosition);
  }
}
