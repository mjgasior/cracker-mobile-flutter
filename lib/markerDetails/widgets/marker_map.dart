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
          onMapCreated: (GoogleMapController controller) async {
            _controller.complete(controller);

            final bool isVisible = await _isMapVisible(controller);
            if (isVisible && userPosition != null) {
              controller.animateCamera(CameraUpdate.newLatLngBounds(
                  _getBounds(userPosition, markerPosition), 50));
            }
          },
          markers: markers,
        ));
  }

  Future<bool> _isMapVisible(GoogleMapController controller) async {
    final LatLngBounds x = await controller.getVisibleRegion();
    final isVisible = x.northeast.longitude != 0 && x.southwest.longitude != 0;
    if (!isVisible) {
      print("There was a bad map size!");
      print(x);
    }
    return isVisible;
  }

  LatLngBounds _getBounds(LatLng userPosition, LatLng markerPosition) {
    if (userPosition.latitude <= markerPosition.latitude) {
      return LatLngBounds(southwest: userPosition, northeast: markerPosition);
    }

    if (userPosition.longitude <= markerPosition.longitude) {
      final southwest = LatLng(markerPosition.latitude, userPosition.longitude);
      final northeast = LatLng(userPosition.latitude, markerPosition.longitude);
      return LatLngBounds(southwest: southwest, northeast: northeast);
    }

    return LatLngBounds(southwest: markerPosition, northeast: userPosition);
  }
}
