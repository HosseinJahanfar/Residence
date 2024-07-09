import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/features/public_features/functions/number_to_three.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/string.dart';
import '../../../const/theme/colors.dart';
import '../model/residence_detail_model.dart';

class ResidenceDatePicker extends StatefulWidget {
  const ResidenceDatePicker({
    super.key,
    required this.helperDetail,
  });

  final ResidenceDetailModel helperDetail;

  @override
  State<ResidenceDatePicker> createState() => _ResidenceDatePickerState();
}

class _ResidenceDatePickerState extends State<ResidenceDatePicker> {
  final Jalali jalali = Jalali.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _format(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: widget.helperDetail.days!.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) {
            final String date = widget.helperDetail.days![index].date!;
            bool isSelected = KeySendDataHost.sendDates.contains(date);

            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    KeySendDataHost.sendDates.remove(date);
                  } else {
                    KeySendDataHost.sendDates.add(date);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: getAllWidth(context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontFamily: 'medium',
                              ),
                            ),
                            Text(
                              getPriceFormat(widget
                                  .helperDetail.days![index].defaultPrice
                                  .toString()),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 8.sp,
                                fontFamily: 'medium',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.helperDetail.days![index].discountPercentage == 0
                        ? const SizedBox.shrink()
                        : Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 1.5.sp),
                              decoration: BoxDecoration(
                                borderRadius: getBorderRadiusFunc(5),
                                color: Colors.red,
                              ),
                              child: Text(
                                '${widget.helperDetail.days![index].discountPercentage}%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontFamily: 'bold',
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }

  //!Year Month
  String _format() {
    final f = jalali.formatter;
    return '${f.mN} ${f.yyyy}';
  }
}
