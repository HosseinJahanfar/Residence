import 'package:flutter/services.dart';

class AccountNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // حذف خط تیره‌ها برای پردازش بهتر
    String newText = newValue.text.replaceAll('-', '');
    final buffer = StringBuffer();

    // اضافه کردن خط تیره‌ها در جای مناسب
    for (int i = 0; i < newText.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write('-');
      }
      buffer.write(newText[i]);
    }

    // محاسبه مکان جدید کرسر
    int selectionIndex = buffer.length - (newText.length - newValue.selection.end);
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
