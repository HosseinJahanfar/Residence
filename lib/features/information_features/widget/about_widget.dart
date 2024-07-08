//!InfoItemsWidget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({
    super.key,
    required this.title,
    required this.iconData,
    required this.function,
  });

  final String title;
  final IconData? iconData;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: SizedBox(
        height: getWidth(context, 0.20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //!container icon
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(getWidth(context, 0.04)),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: getBorderRadiusFunc(15)),
                    child: Icon(
                      iconData,
                      color: primary2Color,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 6,
              child: Column(
                children: [
                  //!row info
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.sp,
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: primary2Color,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'bold',
                                fontSize: 14.sp),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: getWidth(context, 0.06),
                          ),
                        )
                      ],
                    ),
                  ),
                  //!Divider
                  Expanded(
                    flex: 0,
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
