import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/information_features/widget/about_widget.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import 'package:residence/route/names.dart';

import '../widget/info_widget.dart';

class InformationGuest extends StatelessWidget {
  const InformationGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getAllWidth(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: getAllWidth(context),
              height: 50,
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Text(
                'اطلاعات من',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bold',
                    fontSize: 14.sp),
              ),
            ),
            SizedBox(
              width: getAllWidth(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //info
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //!title
                        Text(
                          'میزبانی اقامتگاه',
                          style: TextStyle(
                              color: greyTxtListColor, fontFamily: 'bold'),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        InfoItemsWidget(
                          title: 'تبدیل شدن به میزبان',
                          subTitle:
                              'همین فضا را تبدیل به محیطی برای مدیریت اقامتگاه های خود کنید.',
                          iconData: FontAwesome.exchange,
                          function: () {},
                        ),

                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          'پشتیبانی مشتریان',
                          style: TextStyle(
                              color: greyTxtListColor, fontFamily: 'bold'),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        InfoItemsWidget(
                          title: 'تماس با پشتیبانی',
                          subTitle: 'تماس با پشتیبانی اقامتگاه',
                          iconData: MaterialIcons.support_agent,
                          function: () {
                            Navigator.pushNamed(
                                context, ScreenNames.contactSupport);
                          },
                        ),
                        InfoItemsWidget(
                          title: 'پرسش های متداول',
                          subTitle: 'پاسخ به سوالات و راهنمایی کاربران',
                          iconData:
                              MaterialCommunityIcons.frequently_asked_questions,
                          function: () {
                            getSnackBarWidget(context,
                                'سوالات خود را در سایت بپرسید!', Colors.green);
                          },
                        ),
                        InfoItemsWidget(
                          title: 'امتیاز به اقامتگاه',
                          subTitle:
                              'امتیاز و بازخورد به اپلیکیشن اقامتگاه در مارکت ها',
                          iconData: FontAwesome.star_half_full,
                          function: () {
                            getSnackBarWidget(
                                context,
                                'لینک امتیاز دهی برای شما پیامک می شود.',
                                Colors.green);
                          },
                        ),
                        AboutWidget(
                            title: 'درباره اقامتگاه',
                            iconData:
                                MaterialCommunityIcons.account_question_outline,
                            function: () {
                              Navigator.pushNamed(
                                  context, ScreenNames.aboutScreen);
                            })
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
