//!AmazingWidget
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/connection.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../home_features/model/home_model.dart';
import '../../public_features/functions/number_to_three.dart';

class AmazingWidget extends StatelessWidget {
  const AmazingWidget({
    super.key,
    required this.homeModel,
    required this.theme,
  });

  final HomeModel homeModel;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getAllWidth(context),
      height: getWidth(context, 1),
      color: primary2Color,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'پیشنهاد های\nویژه جاباما تا\n 40% تخفیف',
                    style: TextStyle(
                        fontFamily: 'bold',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: whiteColor),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Image.asset(
                    'assets/images/amazing/amazing_box.png',
                    width: getWidth(context, 0.30),
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: whiteColor),
                      onPressed: () {},
                      child: const Text(
                        'مشاهده همه',
                        style: TextStyle(
                            fontFamily: 'bold',
                            color: primary2Color,
                            fontSize: 12),
                      )),
                ],
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding:
                  EdgeInsets.symmetric(horizontal: getWidth(context, 0.03)),
              itemCount: homeModel.suggestionAccommodation!.length,
              itemBuilder: (context, index) {
                var helper = homeModel.suggestionAccommodation![index];
                return AmazingItem(theme: theme, helper: helper);
              },
            ),
          ],
        ),
      ),
    );
  }
}

//!AmazingItem
class AmazingItem extends StatelessWidget {
  const AmazingItem({
    super.key,
    required this.theme,
    required this.helper,
  });

  final ThemeData theme;
  final SuggestionAccommodation helper;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context, 0.550),
      margin: EdgeInsets.symmetric(
          horizontal: getWidth(context, 0.04),
          vertical: getWidth(context, 0.06)),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: getBorderRadiusFunc(10),
      ),
      child: GestureDetector(
        onTap: () {
          ///OnTab
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: getTopBorderRadiusWidget(7.5),
              child: CachedNetworkImage(
                imageUrl: baseUrl + helper.image!,
                fit: BoxFit.cover,
                width: getAllWidth(context),
                height: getWidth(context, 0.350),
                placeholder: (context, url) => Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${helper.province!} ، ${helper.city!}',
                      style: TextStyle(
                          fontFamily: 'bold',
                          fontSize: 12.sp,
                          color: greyTxtColor),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      helper.title!,
                      style: const TextStyle(
                        fontFamily: 'bold',
                      ),
                    ),
                    Text(
                      '16 تا 17 فروردین، ${helper.discountPercentage!} نفر',
                      style: TextStyle(
                          fontFamily: 'normal',
                          color: greyTxtColor,
                          fontSize: 12.sp),
                    ),
                    Row(
                      children: [
                        Text(
                          '${helper.percentPrice} تومان',
                          style: TextStyle(
                              fontFamily: 'bold',
                              decoration: TextDecoration.lineThrough,
                              decorationColor: greyTxtColor,
                              color: greyTxtColor),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 5.sp),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: getBorderRadiusFunc(50)),
                          child: Text(
                            '${helper.discountPercentage!.toString()}%',
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'bold',
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                '${getPriceFormat(helper.defaultPrice.toString())} تومان',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: primary2Color,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'bold')),
                        TextSpan(
                            text: '/ هرشب',
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: primary2Color,
                                fontFamily: 'medium')),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
