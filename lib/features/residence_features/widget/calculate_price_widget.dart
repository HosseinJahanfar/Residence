import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';
import '../model/calculate_price_model.dart';
import 'outline_btn_widget.dart';

class CalculatePriceWidget extends StatefulWidget {
  const CalculatePriceWidget({super.key, required this.helper});

  final CalculatePriceModel helper;

  @override
  State<CalculatePriceWidget> createState() => _CalculatePriceWidgetState();
}

class _CalculatePriceWidgetState extends State<CalculatePriceWidget> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //!circle container
        Center(
          child: Container(
            width: 100.sp,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: getBorderRadiusFunc(1000)),
          ),
        ),

        Row(
          children: [
            const Icon(AntDesign.calendar),
            SizedBox(
              width: 2.5.sp,
            ),
            SizedBox(
              height: 2.5.sp,
            ),
            Text(' رزو ${KeySendDataHost.sendDates.length} روز')
          ],
        ),

        SizedBox(
          height: 15.sp,
        ),
        //! Section 1
        SizedBox(
          width: getAllWidth(context),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    const Icon(Fontisto.persons),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'تعداد مسافران',
                          style: TextStyle(
                              fontFamily: 'medium',
                              color: Colors.grey.shade500),
                        ),
                        Text(
                          widget.helper.additionalCount.toString(),
                          style: const TextStyle(
                            fontFamily: 'medium',
                          ),
                          textDirection: TextDirection.ltr,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    counter == widget.helper.maximumPerson
                        ? OutlineBtnWidget(
                      iconData: AntDesign.plus,
                      func: null,
                      colors: Colors.grey.shade300,
                    )
                        : OutlineBtnWidget(
                      iconData: AntDesign.plus,
                      func: () {

                      },
                      colors: primary2Color,
                    ),
                    Text(
                      counter.toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                    counter == 1
                        ? OutlineBtnWidget(
                      iconData: Entypo.minus,
                      func: null,
                      colors: Colors.grey.shade300,
                    )
                        : OutlineBtnWidget(
                      iconData: Entypo.minus,
                      func: () {

                      },
                      colors: primary2Color,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Divider(
          height: 1,
          color: Colors.grey.shade300,
        ),
        SizedBox(
          height: 10.sp,
        ),
        //!Section 2
        Text(
          'خلاصه پرداخت',
          style: TextStyle(fontFamily: 'bold', fontSize: 14.sp),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${KeySendDataHost.sendDates.length.toString()} شب اقامتگاه',
              style: TextStyle(fontFamily: 'normal', fontSize: 12.sp),
            ),
            Text(
              '${getPriceFormat(widget.helper.totalPrice.toString())} تومان',
              style: TextStyle(fontFamily: 'normal', fontSize: 12.sp),
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
              '${widget.helper.additionalCount.toString()} نفر اضافه',
              style: TextStyle(fontFamily: 'normal', fontSize: 12.sp),
            ),
            Text(
              '${getPriceFormat(widget.helper.additionalPrice.toString())} تومان'
                  .toString(),
              style: TextStyle(fontFamily: 'normal', fontSize: 12.sp),
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
              'میزان تخفیف',
              style: TextStyle(fontFamily: 'normal', fontSize: 12.sp),
            ),
            Text(
              '${getPriceFormat(widget.helper.totalDiscount.toString())} تومان'
                  .toString(),
              style: TextStyle(fontFamily: 'normal', fontSize: 12.sp),
            ),
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),
        Divider(
          height: 1,
          color: Colors.grey.shade300,
        ),
        SizedBox(
          height: 10.sp,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'جمع مبلغ قابل پرداخت',
              style: TextStyle(fontFamily: 'normal', fontSize: 12.sp),
            ),
            Text(
              '${getPriceFormat(widget.helper.finalPrice.toString())} تومان'
                  .toString(),
              style: TextStyle(fontFamily: 'normal', fontSize: 12.sp),
            ),
          ],
        ),

        SizedBox(
          height: 20.sp,
        ),
        Divider(
          height: 1,
          color: Colors.grey.shade300,
        ),
        SizedBox(
          height: 10.sp,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: getBorderRadiusFunc(5)),
                      backgroundColor: Colors.grey.shade300),
                  onPressed: () {},
                  child: const Text(
                    "بستن",
                    style: TextStyle(fontFamily: 'medium', color: Colors.black),
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 4,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary2Color,
                    shape: RoundedRectangleBorder(
                        borderRadius: getBorderRadiusFunc(5)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "ادامه رزرو",
                    style: TextStyle(fontFamily: 'medium', color: Colors.white),
                  )),
            ),
          ],
        )
      ],
    );
  }
}
