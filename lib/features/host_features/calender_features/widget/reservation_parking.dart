import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../dashboard_features/widget/app_bar_host.dart';

class ReservationParking extends StatefulWidget {
  const ReservationParking({super.key});

  @override
  State<ReservationParking> createState() => _ReservationParkingState();
}

class _ReservationParkingState extends State<ReservationParking> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
      appBar: const AppBarHost(title: 'ثبت پارکینگ'),
      resizeToAvoidBottomInset: false,
        body: Container(

        ),

    ));
  }
}
