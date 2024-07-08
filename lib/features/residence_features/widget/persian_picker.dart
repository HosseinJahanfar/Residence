import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import 'package:residence/features/residence_features/widget/elevated_btn_widget.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../public_features/widget/text_field_price_widget.dart';

//TODO Host Persian Date Picker
class PersianDatePicker extends StatefulWidget {
  const PersianDatePicker({super.key});

  @override
  State<PersianDatePicker> createState() => _PersianDatePickerState();
}

class _PersianDatePickerState extends State<PersianDatePicker> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Jalali jalali = Jalali.now();
  final List<String> _selectedDates = [];
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final List<String> _datesPrice = [];
  final List<String> showDate = [];
  List<Map<String, String>> newList = [];

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidth(
                context,
                0.03,
              ),
              vertical: getWidth(context, 0.03)),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _format(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: jalali.monthLength,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 3),
                          itemBuilder: (context, index) {
                            final String date = _formatDate(
                                jalali.year, jalali.month, index + 1);
                            final bool isSelected =
                                _selectedDates.contains(date);

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    _selectedDates.remove(date);
                                  } else {
                                    _selectedDates.clear();
                                    _selectedDates.add(date);
                                    // print(_formatDate(jalali.year, jalali.month, index + 1));
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: primaryColor)),
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  date,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                      fontFamily: 'dana'),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        titleTextField('قیمت اقامتگاه'),
                        SizedBox(
                          height: 5.sp,
                        ),
                        InputTextFieldPriceWidget(
                          hintText: "لطفاً قیمت اقامتگاه خود را وارد کنید.",
                          textInputAction: TextInputAction.next,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          controller: priceController,
                          maxLength: 12,
                          textInputType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        titleTextField('تخفیف اقامتگاه'),
                        SizedBox(
                          height: 5.sp,
                        ),
                        InputTextFieldDiscountWidget(
                          hintText:
                              "لطفاً میزان تخفیف هر اقامتگاه را وارد کنید.",
                          textInputAction: TextInputAction.done,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          controller: discountController,
                          maxLength: 3,
                          textInputType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        ElevatedBtnWidget(
                          title: 'ثبت تاریخ',
                          func: () {
                            if (_globalKey.currentState!.validate()) {
                              if (_selectedDates.isEmpty ||
                                  priceController.text.trim().isEmpty ||
                                  discountController.text.trim().isEmpty) {
                                getSnackBarWidget(
                                    context,
                                    'لطفا تاریخ و فیلد های قیمت و تخفیف را وارد نمایید.',
                                    Colors.red);
                              } else {
                                _selectedDates.add(priceController.text.trim());
                                _selectedDates
                                    .add(discountController.text.trim());
                                priceController.clear();
                                discountController.clear();

                                if (_datesPrice.contains(_selectedDates[0])) {
                                  getSnackBarWidget(
                                      context,
                                      'این تاریخ از قبل ثبت شده است.',
                                      Colors.pink);
                                } else {
                                  setState(() {
                                    showDate.add(_selectedDates[0]);

                                    for (var element in _selectedDates) {
                                      _datesPrice.add(element);
                                    }
                                  });

                                  print('------------------------------------');
                                  print(_selectedDates.toString());
                                  print(_datesPrice.toString());
                                  print(showDate.toString());
                                  print('------------------------------------');
                                  _selectedDates.clear();
                                }
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),

                        //!show submit detail data
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: showDate.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 5,
                          ),
                          itemBuilder: (context, index) {
                            final dateIndex = index * 3;
                            final priceIndex = dateIndex + 1;
                            final discountIndex = dateIndex + 2;

                            final date = _datesPrice[dateIndex];
                            final price = _datesPrice[priceIndex];
                            final discount = _datesPrice[discountIndex];

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  // Remove data associated with the selected box from the lists
                                  _datesPrice.removeAt(dateIndex);
                                  _datesPrice
                                      .removeAt(dateIndex); // Remove price
                                  _datesPrice
                                      .removeAt(dateIndex); // Remove discount
                                  showDate.removeAt(index);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: primary2Color),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 0.02)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          //! show detail price percentage
                                          showDetail(date),
                                          showDetail(
                                            '$price تومان',
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: discount == '0'
                                          ? const SizedBox.shrink()
                                          : Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 2.5.sp),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      getBorderRadiusFunc(5),
                                                  color: Colors.red),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '$discount%' ?? '',
                                                    // Display discount if available
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 10.sp,
                                                      fontFamily: 'dana',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.sp,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //! End residence
              ElevatedBtnWidget(
                title: 'ثبت اقامتگاه',
                func: () {
                  for (int i = 0; i < _datesPrice.length; i += 3) {
                    // Changed increment to 3
                    Map<String, String> map = {
                      'date': _datesPrice[i],
                      'price': _datesPrice[i + 1],
                      'discount': _datesPrice[i + 2], // Added the discount here
                    };
                    newList.add(map);
                  }
                  print(newList);
                  newList.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text showDetail(String detail) {
    return Text(
      detail,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 10.sp,
        fontFamily: 'dana',
      ),
    );
  }

//!titleTextField
  Text titleTextField(String title) {
    return Text(title,
        style: TextStyle(
          fontFamily: 'bold',
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
          color: primary2Color,
        ));
  }

//!Year Month
  String _format() {
    final f = jalali.formatter;
    return '${f.mN} ${f.yyyy}';
  }

//!Format Date
  String _formatDate(int year, int month, int day) {
    String formattedMonth = month.toString().padLeft(2, '0');
    String formattedDay = day.toString().padLeft(2, '0');
    return '$year/$formattedMonth/$formattedDay';
  }
}
