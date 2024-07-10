import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';

class OutlineBtnWidget extends StatelessWidget {
  const OutlineBtnWidget({super.key, required this.iconData, required this.func, required this.colors});

  final IconData iconData;
  final Function()? func;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          overlayColor: Colors.grey,
          minimumSize: Size(25.sp, 25.sp),
          backgroundColor: Colors.transparent,
          side:  BorderSide(color: colors),
          shape: RoundedRectangleBorder(borderRadius: getBorderRadiusFunc(5))),
      onPressed: func,
      child: Icon(
        iconData,
        size: 18,
        color: colors,
      ),
    );
  }
}