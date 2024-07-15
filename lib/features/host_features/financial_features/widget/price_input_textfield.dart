import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../const/shape/border_radius.dart';
import '../../../../const/theme/colors.dart';

class PriceInputTextFieldWidget extends StatelessWidget {
  const PriceInputTextFieldWidget({
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
      textAlign: TextAlign.center, // Center-align the text
      maxLength: maxLength,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _PriceInputFormatter(),
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

class _PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int selectionIndexFromEnd = newValue.text.length - newValue.selection.end;
    final String newText = _formatPrice(newValue.text);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length - selectionIndexFromEnd),
    );
  }

  String _formatPrice(String value) {
    if (value.isEmpty) return value;
    value = value.replaceAll(',', '');
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      if (i > 0 && (value.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(value[i]);
    }
    return buffer.toString();
  }
}
