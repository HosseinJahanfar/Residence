import 'package:intl/intl.dart';

final formatPattern = NumberFormat('###,###,###');

String getPriceFormat(dynamic price) {
  int parsedPrice;
  if (price is String) {
    // تبدیل رشته به عدد
    parsedPrice = double.tryParse(price) != null ? double.parse(price).toInt() : 0;
  } else if (price is double) {
    // تبدیل عدد شناور به عدد صحیح
    parsedPrice = price.toInt();
  } else if (price is int) {
    // اگر ورودی از نوع عدد صحیح باشد
    parsedPrice = price;
  } else {
    // در غیر این صورت مقدار پیش‌فرض
    parsedPrice = 0;
  }

  // فرمت کردن و برگرداندن قیمت
  return formatPattern.format(parsedPrice);
}
