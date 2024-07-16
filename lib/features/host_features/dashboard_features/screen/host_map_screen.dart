import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/app_bar_host.dart';
import '../widget/flutter_host_map.dart';

class HostMapScreen extends StatelessWidget {
  const HostMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //!id
    final Map<String, dynamic> arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
          appBar: const AppBarHost(title: 'موقعیت مکانی اقامتگاه'),
          body: FlutterHostMapWidget(
            lat: double.parse(arguments['lat']),
            long:  double.parse(arguments['long']),
            initialZoom: 14.sp,
            interAction: true,
          )),
    );
  }
}
