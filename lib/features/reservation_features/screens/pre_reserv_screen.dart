import 'package:flutter/material.dart';

class PreviousReservation extends StatelessWidget {
  const PreviousReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Text('PreviousReservation'),
      ),
    ));
  }
}
