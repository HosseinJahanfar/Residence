import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/media_query.dart';
import '../model/residence_detail_model.dart';

class ResidenceAddressWidget extends StatelessWidget {
  const ResidenceAddressWidget({super.key, required this.helperDetail});
  final ResidenceDetailModel helperDetail;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: getAllWidth(context),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text('آدرس',style: TextStyle(fontFamily: 'bold',fontSize: 14.sp),),
          SizedBox(height: 5.sp,),
          Text(

            helperDetail.address!,
            style: TextStyle(
                fontFamily: 'normal',
                fontSize: 12.sp),
          ),
          SizedBox(height: 15.sp,)
        ],
      ),
    );

  }
}
