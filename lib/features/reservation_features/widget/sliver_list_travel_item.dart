import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';

class SliverListTravelItem extends StatelessWidget {
  const SliverListTravelItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
      child: Container(
        width: getAllWidth(context),
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: getBorderRadiusFunc(5)),
        child: Row(
          children: [
            //! sliver pictures
            Expanded(
              flex: 2,
              child: SizedBox(
                width: getAllWidth(context),
                height: getAllHeight(context),
                child: ClipRRect(
                  borderRadius: getBorderRadiusFunc(5),
                  child: CachedNetworkImage(
                    imageUrl: '',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/logo.png',
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                      fit: BoxFit.contain,
                    ),
                    placeholder: (context, url) => Image.asset(
                      'assets/images/logo.png',
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  width: getAllWidth(context),
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(context, 0.04),
                      vertical: getWidth(context, 0.02)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                       'titile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'bold',
                            fontSize: 10.sp),
                        maxLines: 1,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'شروع قیمت ${getPriceFormat(5000000)} تومان',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'medium',
                              fontSize: 10.sp),
                        ),
                        TextSpan(
                            text: '/هرشب',
                            style: TextStyle(
                                color: greyTxtColor,
                                fontFamily: 'bold',
                                fontSize: 10.sp))
                      ])),

                      //!btn delete favorite
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 30.0, // ارتفاع دلخواه برای دکمه
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              overlayColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(borderRadius: getBorderRadiusFunc(5)),
                              padding: const EdgeInsets.symmetric(horizontal: 8.0), // حذف padding عمودی برای کاهش ارتفاع
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () {},
                            child: Text(
                              'حذف سفر',
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'bold',
                                fontSize: 8.sp, // تنظیم اندازه فونت کوچک‌تر
                              ),
                            ),
                          ),
                        ),
                      )


                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
