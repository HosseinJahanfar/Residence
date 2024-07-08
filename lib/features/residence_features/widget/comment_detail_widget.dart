import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/route/names.dart';

import '../../../const/shape/media_query.dart';
import '../../../const/shape/shape.dart';
import '../../../const/theme/colors.dart';
import '../model/residence_detail_model.dart';

class CommentDetailWidget extends StatelessWidget {
  const CommentDetailWidget({super.key, required this.helperDetail, required this.accommodationId});

  final ResidenceDetailModel helperDetail;
  final int accommodationId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'دیدگاه های شما',
              style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'تعداد دیدگاه ${helperDetail.totalComments}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  fontFamily: 'bold',
                  color: primaryColor),
            )
          ],
        ),
        SizedBox(
          height: 10.sp,
        ),

        ///ListViewBuilder
        if (helperDetail.totalComments == 0)
          Container(
            width: getAllWidth(context),
            height: 180.sp,
            alignment: Alignment.center,
            child: const Text(
              'نظری در مورد این اقامتگاه نوشته نشده است',
              style: TextStyle(),
            ),
          )
        else
          SizedBox(
            width: getAllWidth(context),
            height: 180.sp,
            child: ListView.builder(
              itemCount: helperDetail.comments!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final helperComment = helperDetail.comments;
                return SizedBox(
                  width: getWidth(context, 0.55),
                  height: 160.sp,
                  child: Card(
                    color: Colors.grey.shade50,
                    shape: getShapeFunc(10),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.5.sp, horizontal: 5.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            helperComment![index].fullname!,
                            style:
                                TextStyle(fontFamily: 'bold', fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Expanded(
                            child: Text(
                              helperComment[index].comment!,
                              style: TextStyle(
                                fontFamily: 'normal',
                                fontSize: 12.sp,
                              ),
                              maxLines: 4,
                            ),
                          ),
                          const Divider(),
                          Text(
                            helperComment[index].timeSinceCreated!,
                            style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 10.sp,
                                color: primary2Color),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        InkWell(
                onTap: () {
                  //!Navigator Page Comment
                  Navigator.pushReplacementNamed(context, ScreenNames.showCommentScreen,arguments: {
                    'residence_detail_id':accommodationId
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'نظرات خود را نسبت به این محصول یادداشت کنید',
                        style: TextStyle(
                            fontFamily: 'medium',
                            fontSize: 10.sp,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                    )
                  ],
                ),
              )
      ],
    );
  }
}
