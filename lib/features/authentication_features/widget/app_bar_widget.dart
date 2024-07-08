import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/media_query.dart';

class AppBarScreenWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarScreenWidget({super.key, this.titleAppBar});
  final String? titleAppBar;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
          child: Container(
              width: getAllWidth(context),
              alignment: Alignment.center,
              height: preferredSize.height,
              color: Colors.transparent,
              child: Text(
                titleAppBar!,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bold'),
              )),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(40.sp);
}
