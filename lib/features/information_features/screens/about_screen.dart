import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/shape/media_query.dart';

import '../../../const/theme/colors.dart';
import '../widget/about_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!appbar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgScaffold,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //!back Info
            Navigator.pop(context);
          },
        ),
        title: Text(
          'درباره',
          style: TextStyle(
              fontFamily: 'bold', fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.sp),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/info/logo.png',
                    width: getWidth(context, 0.2),
                  ),
                  SizedBox(height: getWidth(context, 0.05),),
                  AboutWidget(
                      title: 'حریم شخصی کاربران',
                      iconData: Icons.verified_user,
                      function: () {}),
                  AboutWidget(
                      title: 'قوانین و مقررات',
                      iconData: Icons.edit_note_sharp,
                      function: () {}),
                  AboutWidget(
                      title: 'گزارش مشکلات',
                      iconData: Icons.report_gmailerrorred,
                      function: () {}),
                  AboutWidget(
                      title: 'معرفی به اقامتگاه',
                      iconData: Icons.person_outlined,
                      function: () {}),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    'اقامتگاه ما را در شبکه های اجتماعی دنبال کنید',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialMethod(Icons.facebook),
                      SizedBox(
                        width: 10.sp,
                      ),
                      socialMethod(Icons.telegram),
                      SizedBox(
                        width: 10.sp,
                      ),
                      socialMethod(Icons.facebook),
                      SizedBox(
                        width: 10.sp,
                      ),
                      socialMethod(Icons.telegram),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//!socialMethod
  Container socialMethod(IconData iconTheme) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
          color: greyPrimary, borderRadius: getBorderRadiusFunc(10.sp)),
      child: Icon(
        iconTheme,
        size: 30,
      ),
    );
  }
}
