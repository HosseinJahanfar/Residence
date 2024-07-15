import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../const/shape/media_query.dart';
import '../../../../const/theme/colors.dart';
import '../../../../route/names.dart';
import '../../../information_features/widget/about_widget.dart';
import '../../../information_features/widget/info_widget.dart';
import '../../../public_features/widget/snack_bar.dart';
import '../widget/info_host_widget.dart';

class InformationHost extends StatelessWidget {
  const InformationHost({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getAllWidth(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'اطلاعات من',
                style: TextStyle(fontSize: 14.sp, fontFamily: 'bold'),
              ),
              centerTitle: true,
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
                        InfoHostItemsWidget(
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
                        InfoHostItemsWidget(
                          title: 'تماس با پشتیبانی',
                          subTitle: 'تماس با پشتیبانی اقامتگاه',
                          iconData: MaterialIcons.support_agent,
                          function: () {
                            Navigator.pushNamed(
                                context, ScreenNames.contactSupport);
                          },
                        ),
                        InfoHostItemsWidget(
                          title: 'پرسش های متداول',
                          subTitle: 'پاسخ به سوالات و راهنمایی کاربران',
                          iconData:
                              MaterialCommunityIcons.frequently_asked_questions,
                          function: () {
                            getSnackBarWidget(context,
                                'سوالات خود را در سایت بپرسید!', Colors.green);
                          },
                        ),
                        InfoHostItemsWidget(
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
