import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../public_features/functions/number_to_three.dart';
import '../model/residence_detail_model.dart';

class AdditionalPersonWidget extends StatelessWidget {
  const AdditionalPersonWidget({super.key, required this.helperDetail});
  final ResidenceDetailModel helperDetail;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Ionicons.person_add,
            ),
            SizedBox(
              width: 5.sp,
            ),
            Text(
              'نفر اضافه',
              style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: 14.sp),
            )
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),
        Text(
          'هزینه ای که برای نفرات بیش از استاندارد (سرویس خواب و ...) به مبلغ رزرو اضافه می شود.',
          style: TextStyle(
              fontFamily: 'normal',
              fontSize: 12.sp),
        ),
        SizedBox(
          height: 5.sp,
        ),
        RichText(
            text: TextSpan(children: [
              TextSpan(
                text:
                'قیمت هر نفر اضافه به ازای هر شب: ',
                style: TextStyle(
                    fontFamily: 'normal',
                    fontSize: 12.sp,
                    color: Colors.black),
              ),
              TextSpan(
                text:
                '${getPriceFormat(helperDetail.additionalPersonPrice.toString())} تومان ',
                style: TextStyle(
                    fontFamily: 'bold',
                    fontSize: 12.sp,
                    color: Colors.black),
              )
            ]))
      ],
    );
  }
}
