import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/features/host_features/calender_features/model/register_parking_user_model.dart';
import '../../../../const/connection.dart';
import '../../../../const/shape/border_radius.dart';
import '../../../../const/shape/media_query.dart';

class SliverListRegisterParkingUserItem extends StatelessWidget {
  const SliverListRegisterParkingUserItem(
      {super.key, required this.helper, required this.index});

  final List<RegisterParkingUserModel> helper;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
        child: Container(
          width: getAllWidth(context),
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: getBorderRadiusFunc(5)),
          child: Row(
            children: [
              //! sliver pictures
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: getAllWidth(context),
                  height: getAllHeight(context),
                  child: ClipRRect(
                    borderRadius: getBorderRadiusFunc(5),
                    child: CachedNetworkImage(
                      imageUrl: '$baseUrl${helper[index].image}',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/logo.png',
                        errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                        fit: BoxFit.contain,
                      ),
                      placeholder: (context, url) => Image.asset(
                        'assets/images/logo.png',
                        errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    width: getAllWidth(context),
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context, 0.04),
                        vertical: getWidth(context, 0.02)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          helper[index].title!,
                          style: TextStyle(fontFamily: 'bold', fontSize: 12.sp),
                          maxLines: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'استان: ${helper[index].province!}',
                              style: TextStyle(
                                  fontFamily: 'medium',
                                  fontSize: 11.sp,
                                  color: Colors.grey),
                              maxLines: 1,
                            ),
                            Text(
                              'شهر: ${helper[index].city!}',
                              style: TextStyle(
                                  fontFamily: 'medium',
                                  fontSize: 11.sp,
                                  color: Colors.grey),
                              maxLines: 1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
