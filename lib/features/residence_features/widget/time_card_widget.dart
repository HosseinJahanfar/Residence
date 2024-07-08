import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/shape/border_radius.dart';

class TimeCardWidget extends StatelessWidget {
  final String title;
  final String time;

  const TimeCardWidget({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: getBorderRadiusFunc(10.sp),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Icon(
                Ionicons.alarm_outline,
                color: Colors.grey,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: 14.sp,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontFamily: 'medium',
                  fontSize: 12.sp,
                  color: Colors.grey.shade500
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}