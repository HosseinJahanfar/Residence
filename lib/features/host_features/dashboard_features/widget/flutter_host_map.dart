import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';

import '../../../../const/string.dart';
import '../../../../route/names.dart';

class FlutterHostMapWidget extends StatefulWidget {
  const FlutterHostMapWidget({
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
  State<FlutterHostMapWidget> createState() => _FlutterHostMapWidgetState();
}

class _FlutterHostMapWidgetState extends State<FlutterHostMapWidget> {
  double latitude = 0;
  double longitude = 0;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        onTap: (tapPosition, point) {
          setState(() {
            latitude = point.latitude;
            longitude = point.longitude;
          });
          //print("Latitude: ${point.latitude}, Longitude: ${point.longitude}");
        },
        initialCenter: LatLng(widget.lat, widget.long),
        initialZoom: widget.initialZoom,
        interactionOptions: InteractionOptions(
          flags:
              widget.interAction ? InteractiveFlag.all : InteractiveFlag.none,
        ),
      ),
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
              point: LatLng(latitude, longitude),
              width: 25,
              height: 25,
              child: const Icon(
                Ionicons.location,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: getWidth(context, 0.02),
          left: getWidth(context, 0.05),
          right: getWidth(context, 0.05),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary2Color,
              fixedSize: Size(getAllWidth(context), getWidth(context, 0.12)),
            ),
            onPressed: () {
              if (latitude == 0 && longitude == 0) {
                getSnackBarWidget(
                    context, 'لطفا یک مکان را انتخاب نمایید.', Colors.red);
              } else {
                //print("Selected Location - Latitude: $latitude, Longitude: $longitude");
                KeySendDataHost.lat = latitude;
                KeySendDataHost.long = longitude;
                Navigator.pushNamed(context, ScreenNames.uploadImageScreen);
              }
            },
            child: Text(
              "انتخاب موقعیت",
              style: TextStyle(
                  fontSize: 14.sp, fontFamily: 'bold', color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
