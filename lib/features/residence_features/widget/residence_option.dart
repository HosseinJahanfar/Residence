import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../const/theme/colors.dart';
import '../model/residence_detail_model.dart';

class ResidenceOption extends StatelessWidget {
  const ResidenceOption({super.key, required this.residenceDetailModel});

  final ResidenceDetailModel residenceDetailModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: residenceDetailModel.options!.length,
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var helperOption = residenceDetailModel.options![index];
        return Row(
          children: [
            SvgPicture.network(
              helperOption.icon!,
              width: 25,
              height: 25,
              colorFilter:
                  ColorFilter.mode(Colors.grey.shade700, BlendMode.srcIn),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              helperOption.name!,
              style:
                  const TextStyle(fontFamily: 'medium', color: primary2Color),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10.sp,
        );
      },
    );
  }
}
