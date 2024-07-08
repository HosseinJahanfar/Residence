
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    required this.textButton,
    required this.onFuncTab,
    this.isPic = false,
    this.picPath = '',
  });

  final String textButton;
  final Function() onFuncTab;
  final bool isPic;
  final String picPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2),
                color: Colors.transparent),
            child:  ClipRRect(
              borderRadius: getBorderRadiusFunc(1000),
              child:isPic==false? SvgPicture.asset(
                'assets/icons/profile.svg',
                width: 110,
                height: 110,
                color: Colors.grey.shade600,
                fit: BoxFit.contain,
              ):  Image.file(
                File(picPath),
                      width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            )),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                disabledForegroundColor: Colors.transparent,
                side: BorderSide.none),
            onPressed: onFuncTab,
            child: Text(
              textButton,
              style: TextStyle(
                  fontFamily: 'bold',
                  fontWeight: FontWeight.bold,
                  color: primary2Color,
                  fontSize: 12.sp),
            )),
      ],
    );
  }
}
