import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/features/residence_features/model/residence_detail_model.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';

class ReservationBtnWidget extends StatelessWidget {
  const ReservationBtnWidget(
      {super.key, required this.helperDetail, required this.selectedDates});

  final ResidenceDetailModel helperDetail;
  final List<String> selectedDates;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getAllWidth(context),
      height: getWidth(context, 0.2),
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  helperDetail.discountPercentage == 0
                      ? const SizedBox.shrink()
                      : Text(
                          getPriceFormat(helperDetail.percentPrice.toString()),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12.sp),
                        ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  //!box-percentage
                  helperDetail.discountPercentage == 0
                      ? const SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5.sp, horizontal: 5.sp),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 2),
                              color: Colors.red,
                              borderRadius: getBorderRadiusFunc(50.sp)),
                          child: Text(
                            '${helperDetail.discountPercentage.toString()}%',
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.white,
                                fontSize: 12.sp),
                          ),
                        ),
                ],
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text:
                        'شروع قیمت ${getPriceFormat(helperDetail.defaultPrice.toString())} تومان',
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'medium',
                    )),
                TextSpan(
                    text: '/هرشب',
                    style: TextStyle(color: greyTxtColor, fontFamily: 'bold'))
              ])),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary2Color,
              ),
              onPressed: () {
                print(selectedDates);
              },
              child: const Text(
                'رزو اقامتگاه',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'bold',
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
