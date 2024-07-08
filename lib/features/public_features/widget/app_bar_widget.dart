import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarAllWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAllWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(

        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //!back Info
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: TextStyle(
              fontFamily: 'bold', fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
