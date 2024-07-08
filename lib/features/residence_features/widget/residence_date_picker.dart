import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../const/theme/colors.dart';
import '../model/residence_detail_model.dart';

class ResidenceDatePicker extends StatefulWidget {
  const ResidenceDatePicker(
      {super.key, required this.selectedDates, required this.helperDetail});

  final ResidenceDetailModel helperDetail;
  final List<String> selectedDates;

  @override
  State<ResidenceDatePicker> createState() => _ResidenceDatePickerState();
}

class _ResidenceDatePickerState extends State<ResidenceDatePicker> {
  final Jalali jalali = Jalali.now();

  @override
  Widget build(BuildContext context) {
    return Column(
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
          itemCount: widget.helperDetail.days!.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 3),
          itemBuilder: (context, index) {
            final String date =
                _formatDate(jalali.year, jalali.month, index + 1);
            bool isSelected = widget.selectedDates.contains(date);

            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    widget.selectedDates.remove(date);
                  } else {
                    widget.selectedDates.add(date);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: primaryColor)),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
      ],
    );
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
