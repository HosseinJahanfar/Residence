import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class EmptyCommentWidget extends StatelessWidget {
  const EmptyCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/questions.svg',
            width: getWidth(context, 0.6),
            placeholderBuilder: (context) {
              return const SpinKitFadingCircle(
                color: primaryColor,
              );
            },
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            'برای این اقامتگاه نظری ثبت نشده است!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'bold',
                fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
