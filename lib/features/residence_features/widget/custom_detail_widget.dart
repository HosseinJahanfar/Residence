import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/theme/colors.dart';

class CustomDetailWidget extends StatelessWidget {
  const CustomDetailWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.desc,
  });

  final IconData iconData;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            iconData,
            size: 40,
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bold',
                    fontSize: 14.sp),
              ),
              SizedBox(height: 2.5.sp,),
              Text(
                desc,
                style: TextStyle(fontFamily: 'normal',color: Colors.grey.shade500),
                overflow: TextOverflow.visible, textAlign: TextAlign.justify,
              )
            ],
          ),
        )
      ],
    );
  }
}
