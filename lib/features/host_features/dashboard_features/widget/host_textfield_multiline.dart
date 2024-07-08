import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../const/shape/border_radius.dart';
import '../../../../const/theme/colors.dart';

class HostTextFormFieldMultiLine extends StatelessWidget {
  final int minLine;
  final int maxLine;
  final Widget? icon;
  final String hintText;
  final int maxLength;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputType textInputType;
  final TextEditingController controller;

  const HostTextFormFieldMultiLine({
    super.key,
    required this.minLine,
    required this.maxLine,
    required this.textInputAction,
    required this.textInputType,
    required this.floatingLabelBehavior,
    required this.controller,
    required this.icon,
    required this.hintText, required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      style: theme.textTheme.bodyMedium,
      cursorColor: primary2Color,
      // textInputAction: textInputAction,
      keyboardType: textInputType,
      minLines: minLine,
      maxLines: maxLine,
      controller: controller,
      maxLength: maxLength,
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
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return 'این فیلد نمی تواند خالی باشد';
        }

        return null;
      },
      onTap: () {
        if (controller.text.isNotEmpty) {
          if (controller.text[controller.text.length - 1] != ' ') {
            controller.text = ('${controller.text} ');
          }
          if (controller.selection ==
              TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length - 1))) {}
        }
      },
    );
  }
}
