import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/features/residence_features/widget/time_card_widget.dart';

import '../../../const/shape/media_query.dart';
import '../model/residence_detail_model.dart';

class RulesAndRegulationsWidget extends StatelessWidget {
  const RulesAndRegulationsWidget({super.key, required this.helperDetail});

  final ResidenceDetailModel helperDetail;

  @override
  Widget build(BuildContext context) {
    return helperDetail.regulations!.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'قوانین و مقررات اقامتگاه',
                style: TextStyle(fontFamily: 'bold', fontSize: 14.sp),
              ),
              SizedBox(
                height: 15.sp,
              ),
              SizedBox(
                width: getAllWidth(context),
                height: getWidth(context, 0.3),
                child: Row(
                  children: [
                    TimeCardWidget(
                        title: 'ساعت ورود', time: helperDetail.checkInTime!),
                    SizedBox(
                      width: 10.sp,
                    ),
                    TimeCardWidget(
                        title: 'ساعت خروج', time: helperDetail.checkOutTime!),
                  ],
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              SizedBox(
                width: getAllWidth(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.assignment_add,
                      size: 26.sp,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(
                      'مقررات اقامتگاه',
                      style: TextStyle(fontFamily: 'bold', fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              //! regulation residence
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: helperDetail.regulations!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    width: getAllWidth(context),
                    padding: EdgeInsets.symmetric(vertical: 5.sp),
                    child: Row(
                      children: [
                        helperDetail.regulations![index].isAllowed!
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                        SizedBox(
                          width: 5.sp,
                        ),
                        Text(
                          helperDetail.regulations![index].name!,
                          style: TextStyle(
                              fontFamily: 'normal',
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
  }
}
