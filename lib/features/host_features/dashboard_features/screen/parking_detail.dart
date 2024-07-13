import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../const/shape/border_radius.dart';
import '../../../../const/shape/media_query.dart';
import '../../../../const/string.dart';
import '../../../../const/theme/colors.dart';
import '../../../../route/names.dart';
import '../model/host_model.dart';
import '../widget/app_bar_host.dart';
import '../widget/host_textfield.dart';
import '../widget/host_textfield_multiline.dart';

class ParkingDetail extends StatefulWidget {
  const ParkingDetail({super.key});

  @override
  State<ParkingDetail> createState() => _ParkingDetailState();
}

class _ParkingDetailState extends State<ParkingDetail> {
  final TextEditingController _entryTimeController = TextEditingController();
  final TextEditingController _exitTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _capacityParkingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form

  TimeOfDay? _selectedEntryTime;
  TimeOfDay? _selectedExitTime;
  bool _hasShade = false;

  @override
  void dispose() {
    super.dispose();
    _entryTimeController.dispose();
    _exitTimeController.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isEntryTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Colors.black,
              hourMinuteTextColor: Colors.black,
              dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? Colors.black
                      : Colors.black),
              dayPeriodColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? Colors.black
                      : Colors.black),
              helpTextStyle: const TextStyle(color: Colors.black),
              entryModeIconColor: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  overlayColor: Colors.black,
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(color: Colors.black)),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null &&
        picked != (isEntryTime ? _selectedEntryTime : _selectedExitTime)) {
      setState(() {
        if (isEntryTime) {
          _selectedEntryTime = picked;
          _entryTimeController.text = picked.format(context);
        } else {
          _selectedExitTime = picked;
          _exitTimeController.text = picked.format(context);
        }
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return "";
    final int hour = timeOfDay.hour;
    final int minute = timeOfDay.minute;
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: const AppBarHost(title: 'مشخصات پارکینگ'),
      body: Container(
        width: getAllWidth(context),
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.03)),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assigning _formKey to the Form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'توضیحات پارکینگ',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                HostTextFormFieldMultiLine(
                    minLine: 3,
                    maxLine: 6,
                    maxLength: 60,
                    hintText: 'در این قسمت پارکینگ خود را کامل شرح دهید.',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.multiline,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _descriptionController,
                    icon: const Icon(Icons.edit_outlined)),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'ظرفیت پارکینگ',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                HostInputTextFieldWidget(
                  hintText: 'مانند: 2 ظرفیت',
                  textInputAction: TextInputAction.next,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  controller: _capacityParkingController,
                  maxLength: 2,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'ساعت ورود',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                GestureDetector(
                  onTap: () => _selectTime(context, true),
                  child: AbsorbPointer(
                    child: HostInputTextFieldWidget(
                      hintText: 'مانند: 12:00',
                      textInputAction: TextInputAction.next,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      controller: _entryTimeController,
                      textInputType: TextInputType.number,
                      maxLength: 6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'ساعت خروج',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                GestureDetector(
                  onTap: () => _selectTime(context, false),
                  child: AbsorbPointer(
                    child: HostInputTextFieldWidget(
                      hintText: 'مانند: 8:00',
                      textInputAction: TextInputAction.next,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      controller: _exitTimeController,
                      textInputType: TextInputType.number,
                      maxLength: 6,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'سایه‌بان:',
                      style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                    ),
                    Row(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: _hasShade,
                          activeColor: primary2Color,
                          onChanged: (bool? value) {
                            setState(() {
                              _hasShade = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'دارد',
                          style:
                              TextStyle(fontFamily: 'normal', fontSize: 12.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<bool>(
                          value: false,
                          groupValue: _hasShade,
                          activeColor: primary2Color,
                          onChanged: (bool? value) {
                            setState(() {
                              _hasShade = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'ندارد',
                          style:
                              TextStyle(fontFamily: 'normal', fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                //!ElevatedButton Submit
                const Divider(),
                SizedBox(
                  height: 15.sp,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary2Color,
                      shape: RoundedRectangleBorder(
                        borderRadius: getBorderRadiusFunc(20.sp),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(context, 0.3),
                        vertical: getWidth(context, 0.03),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final String checkInTime =
                            _formatTimeOfDay(_selectedEntryTime);
                        final String checkOutTime =
                            _formatTimeOfDay(_selectedExitTime);

                        if (checkInTime.isEmpty || checkOutTime.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'لطفاً زمان ورود و خروج را انتخاب کنید.')),
                          );
                          return;
                        }
                        KeySendDataHost.descriptionParking =
                            _descriptionController.text;
                        KeySendDataHost.capacityParking =
                            int.parse(_capacityParkingController.text);
                        KeySendDataHost.checkInTimeParking =
                            _entryTimeController.text;
                        KeySendDataHost.checkOutTimeParking =
                            _entryTimeController.text;
                        KeySendDataHost.isCheckedParking = _hasShade;
                        Navigator.pushNamed(
                          context,
                          ScreenNames.addressParkingScreen,
                            arguments: {'parking_id': arguments['parking_id']}
                        );
                      }
                    },
                    child: Text(
                      "ثبت و ادامه",
                      style: TextStyle(
                        fontFamily: 'bold',
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
