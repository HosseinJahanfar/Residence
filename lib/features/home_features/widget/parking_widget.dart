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
              return Container(
                width: getWidth(context, 0.6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.sp),
                      topRight: Radius.circular(10.sp)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),

                      spreadRadius: 8,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // موقعیت سایه: (افقی، عمودی)
                    ),
                  ],
                ),
                // color: Colors.pink,
                child: Column(
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            helper.title!,
                            style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'استان : ${helper.province}',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: 'normal',
                                    color: Colors.grey.shade500),
                              ),
                              Text(
                                'شهر : ${helper.city}',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: 'normal',
                                    color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'نوع پارکینگ : ${helper.parkingType}',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: 'medium',
                                    color: Colors.grey.shade500),
                              ),
                              Text(
                                'ظرفیت خالی : ${helper.remainingCapacity}',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: 'medium',
                                    color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Center(
                              child: Text(
                            'قیمت پارکینگ: ${getPriceFormat(helper.price)}',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'medium',
                                color: Colors.black),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: getWidth(context, 0.06),
              );
            },
          ),
        ),
      ],
    );
  }
}
