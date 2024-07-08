import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../const/shape/border_radius.dart';
import '../../../const/theme/colors.dart';

//!InputTextFieldPriceWidget
class InputTextFieldPriceWidget extends StatelessWidget {
  const InputTextFieldPriceWidget({
    super.key,
    required this.hintText,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
    required this.maxLength,
    required this.textInputType,
  });

  final String hintText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final int maxLength;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      textAlign: TextAlign.start,
      maxLength: maxLength,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ThousandsFormatter()
        // This allows only digits
      ],
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return 'این فیلد نمی تواند خالی باشد';
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

//!InputTextFieldDiscountWidget
class InputTextFieldDiscountWidget extends StatelessWidget {
  const InputTextFieldDiscountWidget({
    super.key,
    required this.hintText,
    required this.textInputAction,
    required this.floatingLabelBehavior,
    required this.controller,
    required this.maxLength,
    required this.textInputType,
  });

  final String hintText;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextEditingController controller;
  final int maxLength;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      textAlign: TextAlign.start,
      maxLength: maxLength,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ThousandsFormatter()
        // This allows only digits
      ],
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return 'این فیلد نمی تواند خالی باشد';
        }

        // Convert input string to an integer (remove commas if any)
        final input = int.parse(value.replaceAll(',', ''));

        // Check if the input is greater than 100
        if (input > 100) {
          return "لطفا درصد تخفیف را کمتر از 100 وارد نمایید.";
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

// A TextInputFormatter implementation to format numeric input with thousand separators.
class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final num value = int.parse(newValue.text.replaceAll(',', ''));
    final formatter = NumberFormat("#,###");
    final newText = formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
