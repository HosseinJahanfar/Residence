import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapWidget extends StatelessWidget {
  const FlutterMapWidget({
    super.key,
    required this.lat,
    required this.long,
    required this.initialZoom,
    required this.interAction,
  });

  final double lat;
  final double long;
  final double initialZoom;
  final bool interAction;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          initialCenter: LatLng(lat, long),
          initialZoom: initialZoom,
          interactionOptions: InteractionOptions(
              flags: interAction ? InteractiveFlag.all : InteractiveFlag.none)),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/hossein0011/clwhkqerp00ev01qxbin33ip5/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaG9zc2VpbjAwMTEiLCJhIjoiY2x3aGtrZWQ0MGd5dDJya3gzbmk4cnd1eSJ9.jFqfas7FSkL1DIILb5CwSQ',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              rotate: true,
              point: LatLng(lat, long),
              width: 20,
              height: 20,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    MaterialIcons.location_on,
                    color: Colors.green,
                    size: 35.0,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
