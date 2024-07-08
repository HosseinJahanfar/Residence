import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentReservation extends StatelessWidget {
  const CurrentReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
      body: Center(child: Text('CurrentReservation'),),
    ));
  }
}
