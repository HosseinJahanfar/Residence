import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/connection.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';
import '../logic/favorite_bloc.dart';
import '../model/favorite_model.dart';

class SliverListFavoriteItem extends StatelessWidget {
  const SliverListFavoriteItem({super.key, required this.helperIndex});

  final AllFavorite helperIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
      child: Container(
        width: getAllWidth(context),
        height: 150,
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
                    imageUrl: '$baseUrl${helperIndex.image}',
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
                        helperIndex.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'bold',
                            fontSize: 10.sp),
                        maxLines: 1,
                      ),

                      Row(
                        children: [
                          helperIndex.discountPercentage == 0
                              ? const SizedBox.shrink()
                              : Text(
                                  getPriceFormat(
                                      helperIndex.percentPrice.toString()),
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontSize: 12.sp),
                                  maxLines: 1,
                                ),
                          SizedBox(
                            width: 5.sp,
                          ),
                          helperIndex.discountPercentage == 0
                              ? const SizedBox.shrink()
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.5.sp, horizontal: 5.sp),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.red, width: 2),
                                      color: Colors.red,
                                      borderRadius: getBorderRadiusFunc(50.sp)),
                                  child: Text(
                                    '${helperIndex.discountPercentage.toString()}%',
                                    style: TextStyle(
                                        fontFamily: 'bold',
                                        color: Colors.white,
                                        fontSize: 12.sp),
                                    maxLines: 1,
                                  ),
                                ),
                        ],
                      ),

                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text:
                              'شروع قیمت ${getPriceFormat(helperIndex.defaultPrice.toString())} تومان',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'medium',
                              fontSize: 10.sp),
                        ),
                        TextSpan(
                            text: '/هرشب',
                            style: TextStyle(
                                color: greyTxtColor,
                                fontFamily: 'bold',
                                fontSize: 10.sp))
                      ])),

                      //!btn delete favorite

                      Align(
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                                backgroundColor: Colors.transparent),
                            onPressed: () {
                              context
                                  .read<FavoriteBloc>()
                                  .add(RemoveFavoriteEvent(helperIndex.id!));
                            },
                            child: Text(
                              'حذف از علاقه مندی ها',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'bold',
                                  fontSize: 10.sp),
                            )),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
