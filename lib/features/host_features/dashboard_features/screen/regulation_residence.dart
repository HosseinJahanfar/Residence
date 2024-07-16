import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/host_features/dashboard_features/model/host_model.dart';
import 'package:residence/route/names.dart';
import '../../../../const/shape/media_query.dart';
import '../../../../const/string.dart';
import '../widget/app_bar_host.dart';
import '../widget/host_textfield.dart';

class RegulationResidence extends StatefulWidget {
  const RegulationResidence({super.key});

  @override
  State<RegulationResidence> createState() => _RegulationResidenceState();
}

class _RegulationResidenceState extends State<RegulationResidence> {
  final TextEditingController _entryTimeController = TextEditingController();
  final TextEditingController _exitTimeController = TextEditingController();
  final List<int> selectedIds = [];
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form

  TimeOfDay? _selectedEntryTime;
  TimeOfDay? _selectedExitTime;

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
    final HostModel hostModel = arguments['data_id'] as HostModel;

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarHost(title: 'مقررات اقامتگاه'),
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
                  Text(
                    'مقررات',
                    style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  ListView.builder(
                    itemCount: hostModel.regulations?.length ?? 0,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final regulation = hostModel.regulations?[index];
                      if (regulation == null) {
                        return const SizedBox.shrink();
                      }
                      return CheckboxListTile(
                        activeColor: primary2Color,
                        title: Text(regulation.name ?? "نامشخص"),
                        value: selectedIds.contains(regulation.id),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedIds.add(regulation.id!);
                            } else {
                              selectedIds.remove(regulation.id!);
                            }
                            // print("Selected ID: ${regulation.id}");
                          });
                        },
                      );
                    },
                  ),
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
      
                          // مقررات انتخاب شده
                          final selectedRegulations = selectedIds;
      
                          // چاپ زمان ورود، خروج و ID مقررات انتخاب شده
                          // print("Check-In Time: $checkInTime");
                          // print("Check-Out Time: $checkOutTime");
                          // print("Selected Regulation IDs: $selectedRegulations");
                          KeySendDataHost.regulations.clear();
                          KeySendDataHost.checkInTime = checkInTime;
                          KeySendDataHost.checkOutTime = checkOutTime;
                          KeySendDataHost.regulations = selectedRegulations;
                          Navigator.pushNamed(
                            context,
                            ScreenNames.addressResidenceScreen,
                            arguments: {
                              'data_id': arguments['data_id'],
                              'check_in_time': checkInTime,
                              'check_out_time': checkOutTime,
                              'selected_regulations': selectedRegulations,
                            },
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
      ),
    );
  }
}
