import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/connection.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';
import '../model/home_model.dart';

class ParkingWidget extends StatelessWidget {
  const ParkingWidget({super.key, required this.homeModel});

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidth(
            context,
            0.05,
          )),
          child: Text(
            'پارکینگ',
            style: TextStyle(fontFamily: 'bold', fontSize: 14.sp),
          ),
        ),
        SizedBox(
          height: 12.5.sp,
        ),
        SizedBox(
          width: getAllWidth(context),
          height: getWidth(context, 0.7),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            itemCount: homeModel.parkingsInBigCities!.length,
            itemBuilder: (context, index) {
              var helper = homeModel.parkingsInBigCities![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: getWidth(context, 0.6),
                    height: getWidth(context, 0.36),
                    child: ClipRRect(
                        borderRadius: getBorderRadiusFunc(10),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/logo.png',
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                          imageUrl: baseUrl + helper.image!,
                          fit: BoxFit.cover,
                          width: getWidth(context, 0.40),
                        )),
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  Text(
                    helper.title!,
                    style: TextStyle(
                      fontFamily: 'bold',
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  helper.discountPercentage == 0
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.5.sp),
                          child: Text(
                            '${helper.province!} ، ${helper.city!}',
                            style: TextStyle(
                                fontFamily: 'medium',
                                fontSize: 12.sp,
                                color: greyTxtColor),
                          ),
                        )
                      : Text(
                          '${helper.province!} ، ${helper.city!}',
                          style: TextStyle(
                              fontFamily: 'medium',
                              fontSize: 12.sp,
                              color: greyTxtColor),
                        ),
                  Row(
                    children: [
                      helper.discountPercentage == 0
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.5.sp),
                              child: RichText(
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
                              ),
                            )
                          : Text(
                              '${getPriceFormat(helper.percentPrice!.toString())} تومان',
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: greyTxtColor,
                                  color: greyTxtColor),
                            ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      helper.discountPercentage == 0
                          ? const SizedBox.shrink()
                          : Container(
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
                  helper.discountPercentage == 0
                      ? const SizedBox.shrink()
                      : RichText(
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
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: getWidth(context, 0.06),
              );
            },
          ),
        )
      ],
    );
  }
}
