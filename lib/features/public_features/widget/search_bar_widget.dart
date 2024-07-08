import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, SearchScreen.screenId);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
            horizontal: getWidth(
              context,
              0.05,
            ),
            vertical: 8.sp),
        height: Responsive.isTablet(context) ? 80 : 60,
        decoration: BoxDecoration(
          color: bgWhite,
          boxShadow: [
            BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)
          ],
          border:
              const Border(bottom: BorderSide(color: primaryColor, width: 3)),
          borderRadius: getBorderRadiusFunc(5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.020)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                color: greyPrimary,
                size: 25,
              ),
              SizedBox(width: getWidth(context, 0.01)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'جستجو شهر، استان یا اقامتگاه',
                    style: Responsive.isTablet(context)
                        ? TextStyle(
                            fontSize: 10.sp,
                            fontFamily: 'medium',
                            color: greyPrimary)
                        : TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'medium',
                            color: greyPrimary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
