import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/route/names.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.cottage_outlined)),
            const Spacer(),
            Text(
              'داشبورد',
              style: TextStyle(fontSize: 14.sp, fontFamily: 'bold'),
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.local_parking)),
          ],
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.02)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/dashboard.svg',
                  width: getWidth(context, 0.5),
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Text(
                  'اقامتگاهی ثبت شده ندارید',
                  style: TextStyle(fontFamily: 'bold', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'اگر اقامتگاه و یا پارکینگ خود را ثبت کرده اید منتظر تایید آن توسط پشتیبانی اقامتگاه باشید.',
                  style: TextStyle(
                    fontFamily: 'normal',
                    fontSize: 12.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                const Divider(),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'در صورتی که اقامتگاهی و یا پارکینگ ثبت نکرده اید می توانید اولین اقامتگاه و پارکینگ خود را ثبت کنید.',
                  style: TextStyle(
                    fontFamily: 'normal',
                    fontSize: 12.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: getBorderRadiusFunc(5)),
                        backgroundColor: primary2Color),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ScreenNames.typeResidenceScreen);
                    },
                    child: Text(
                      'ثبت اولین اقامتگاه',
                      style: TextStyle(
                          fontFamily: 'medium',
                          fontSize: 12.sp,
                          color: Colors.white),
                    )),
                SizedBox(
                  height: 2.5.sp,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: getBorderRadiusFunc(5)),
                        backgroundColor: primary2Color),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ScreenNames.typeParkingScreen);
                    },
                    child: Text(
                      'ثبت اولین پارکینگ',
                      style: TextStyle(
                          fontFamily: 'medium',
                          fontSize: 12.sp,
                          color: Colors.white),
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
