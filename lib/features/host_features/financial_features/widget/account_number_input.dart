import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../const/shape/border_radius.dart';
import '../../../../const/theme/colors.dart';
import 'account_number_formatter.dart';  // اطمینان حاصل کنید که مسیر واردات درست است

class AccountNumberInputTextFieldWidget extends StatelessWidget {
  const AccountNumberInputTextFieldWidget({
    super.key,
    required this.hintText,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
    required this.maxLength,
  });

  final String hintText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,  // تغییر این قسمت برای وسط‌چین کردن متن
      maxLength: maxLength + (maxLength ~/ 4) - 1,  // اصلاح حداکثر طول برای جلوگیری از خط تیره اضافی
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        AccountNumberFormatter(),
      ],
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'این فیلد نمی‌تواند خالی باشد';
        }
        if (value.replaceAll('-', '').length != maxLength) {
          return 'شماره حساب باید $maxLength رقم باشد';
        }
        return null;
      },
      textInputAction: textInputAction,
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        fillColor: Colors.transparent,
        filled: true,
        hintText: hintText,
        counter: const SizedBox.shrink(),
        border: OutlineInputBorder(
          borderRadius: getBorderRadiusFunc(5.sp),
          borderSide: const BorderSide(width: 1, color: primary2Color),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: getBorderRadiusFunc(5.sp),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: getBorderRadiusFunc(5.sp),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
      ),
    );
  }
}
