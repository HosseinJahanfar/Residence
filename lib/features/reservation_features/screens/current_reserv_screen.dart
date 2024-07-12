import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/features/reservation_features/widget/sliver_list_travel_item.dart';

import '../../../const/shape/media_query.dart';

class CurrentReservation extends StatelessWidget {
  const CurrentReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 5.sp),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
               // helper.allFavorite!.length
                childCount:4 ,
                    (context, index) {
                  //AllFavorite helperIndex = helper.allFavorite![index];
                  return SliverListTravelItem();
                },
              )),
        )
      ],
    );
  }
}
