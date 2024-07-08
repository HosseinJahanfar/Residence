//!ResidenceList
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/route/names.dart';

import '../../../const/connection.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class ResidenceList extends StatelessWidget {
  const ResidenceList({
    super.key,
    required this.homeModel,
    required this.title,
  });

  final String title;
  final List<dynamic> homeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidth(
            context,
            0.05,
          )),
          child: Text(
            title,
            style: TextStyle(fontFamily: 'bold', fontSize: 14.sp),
          ),
        ),
        SizedBox(
          height: 12.5.sp,
        ),
        SizedBox(
          width: getAllWidth(context),
          height: getWidth(context, 0.450),
          child: ListView.separated(
            itemCount: homeModel.length,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var helper = homeModel[index];
              return GestureDetector(
                onTap: () {
                  //!sendId
                  Navigator.pushNamed(context, ScreenNames.residenceListScreen,
                      arguments: {'residence_id': helper.id});
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: getWidth(context, 0.30),
                      height: getWidth(context, 0.35),
                      child: ClipRRect(
                          borderRadius: getBorderRadiusFunc(10),
                          child: CachedNetworkImage(
                            imageUrl: baseUrl + helper.picture!,
                            fit: BoxFit.cover,
                            width: getWidth(context, 0.40),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/logo.png'),
                            placeholder: (context, url) => Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.sp),
                      child: SizedBox(
                        width: getWidth(context, 0.30),
                        child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: '${helper.name}، ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primary2Color)),
                              TextSpan(
                                text: helper.province,
                                style: TextStyle(
                                  color: greyTxtListColor,
                                ),
                              )
                            ])),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 5.sp,
              );
            },
          ),
        )
      ],
    );
  }
}
