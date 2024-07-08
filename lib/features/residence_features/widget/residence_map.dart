import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'flutter_map_widget.dart';

class ResidenceMap extends StatelessWidget {
  const ResidenceMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'موقعیت مکانی اقامتگاه',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'bold',
                  fontSize: 14.sp),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          body: FlutterMapWidget(
            lat: 36.31559,
            long: 59.56796,
            initialZoom: 14.sp,
            interAction: true,
          )),
    );
  }
}
