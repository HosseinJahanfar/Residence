import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/string.dart';

import '../../../const/connection.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/functions/number_to_three.dart';
import '../model/residence_list_model.dart';

class ItemResidenceListView extends StatelessWidget {
  const ItemResidenceListView({super.key, required this.helper});

  final Accommodations helper;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //!sendId
        KeySendDataHost.detailId=helper.id!;
        Navigator.pushNamed(context, ScreenNames.residenceDetailScreen);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: getAllWidth(context),
                height: getWidth(context, 0.5),
                child: ClipRRect(
                    borderRadius: getBorderRadiusFunc(15.sp),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
                      imageUrl: baseUrl + helper.image!,
                      fit: BoxFit.cover,
                    ))),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              helper.title.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'bold',
                  fontSize: 12.sp),
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              '${helper.province},${helper.city}.${helper.roomCount}اتاق,${helper.minimumCapacity} نفر پایه',
              style: TextStyle(
                  fontFamily: 'normal',
                  color: Colors.grey[600],
                  fontSize: 11.sp),
            ),
            helper.discountPercentage == 0
                ? const SizedBox.shrink()
                : SizedBox(
                    height: 10.sp,
                  ),
            //!box-percentage
            helper.discountPercentage == 0
                ? const SizedBox.shrink()
                : Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 2.5.sp, horizontal: 20.sp),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        color: Colors.red[50],
                        borderRadius: getBorderRadiusFunc(50.sp)),
                    child: Text(
                      '${helper.discountPercentage.toString()}% درصد تخفیف',
                      style: TextStyle(
                          fontFamily: 'bold',
                          color: Colors.red,
                          fontSize: 12.sp),
                    ),
                  ),
            SizedBox(
              height: 5.sp,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text:
                      'شروع قیمت ${getPriceFormat(helper.percentPrice.toString())} تومان',
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'medium',
                  )),
              TextSpan(
                  text: '/هرشب',
                  style: TextStyle(color: greyTxtColor, fontFamily: 'bold'))
            ]))
          ],
        ),
      ),
    );
  }
}
