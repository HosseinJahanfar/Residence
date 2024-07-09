import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';

class OutlineBtnWidget extends StatelessWidget {
  const OutlineBtnWidget({super.key, required this.iconData, required this.func});

  final IconData iconData;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          overlayColor: Colors.grey,
          minimumSize: Size(25.sp, 25.sp),
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: primary2Color),
          shape: RoundedRectangleBorder(borderRadius: getBorderRadiusFunc(5))),
      onPressed: func,
      child: Icon(
        iconData,
        size: 18,
        color: primary2Color,
      ),
    );
  }
}
