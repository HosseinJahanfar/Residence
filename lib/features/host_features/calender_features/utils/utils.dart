
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/theme/colors.dart';

class Utils {
  static Text showDetail(String detail) {
    return Text(
      detail,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 10.sp,
        fontFamily: 'medium',
      ),
    );
  }

  static Text titleTextField(String title) {
    return Text(title,
        style: TextStyle(
          fontFamily: 'bold',
          fontSize: 14.sp,
          color: primary2Color,
        ));
  }

  static String format(Jalali jalaliDate) {
    final f = jalaliDate.formatter;
    return '${f.mN} ${f.yyyy}';
  }

  static String formatDate(int year, int month, int day) {
    String formattedMonth = month.toString().padLeft(2, '0');
    String formattedDay = day.toString().padLeft(2, '0');
    return '$year/$formattedMonth/$formattedDay';
  }
}
