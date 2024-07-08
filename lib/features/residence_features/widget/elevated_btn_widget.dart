import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';

class ElevatedBtnWidget extends StatelessWidget {
  const ElevatedBtnWidget({
    super.key, required this.title, required this.func,
  });
  final String title;
  final Function() func;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: primary2Color,
            shape: RoundedRectangleBorder(
                borderRadius: getBorderRadiusFunc(5)),
            fixedSize: Size(
              getAllWidth(context),
              getWidth(context, 0.10),
            )),
        onPressed: func,
        child:  Text(title,style: const TextStyle(fontFamily: 'bold',fontWeight: FontWeight.bold),));
  }
}