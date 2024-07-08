//!BrandsWidgets
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/theme/colors.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../model/home_model.dart';

class CategoryWidgets extends StatelessWidget {
  CategoryWidgets({super.key, required this.theme});

  final ThemeData theme;
  final List<String> pathPic = [
    'assets/images/grouping/1.png',
    'assets/images/grouping/2.png',
    'assets/images/grouping/3.png',
    'assets/images/grouping/4.png',
    'assets/images/grouping/5.png',
    'assets/images/grouping/6.png',
  ];
  final List<String> txtPic = [
    'کلبه',
    'ویلا',
    'اپارتمان',
    'ساحلی',
    'استخردار',
    'پارکینگ',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getAllWidth(context),
      margin: EdgeInsets.symmetric(horizontal: getWidth(context, 0.06)),
      child: GridView.builder(
        itemCount: pathPic.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 40.sp, mainAxisSpacing: 5.sp),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //comment Grouping
              //TODO Grouping
              print(index);
            },
            child: Column(
              children: [
                Container(
                  width: getAllWidth(context),
                  height: getWidth(context, 0.170),
                  padding: EdgeInsets.all(5.sp),
                  decoration:
                      BoxDecoration(borderRadius: getBorderRadiusFunc(0)),
                  child: FadeInImage(
                    placeholder: const AssetImage(
                      'assets/images/logo.png',
                    ),
                    image: AssetImage(pathPic[index]),
                  ),
                ),
                Text(
                  txtPic[index],
                  style: TextStyle(fontFamily: 'bold', fontSize: 10.sp),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
