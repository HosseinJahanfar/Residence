import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/host_features/calender_features/logic/send_date_picker_residence/send_date_picker_residence_bloc.dart';
import 'package:residence/features/host_features/calender_features/services/calender_repository.dart';
import 'package:residence/features/host_features/calender_features/utils/utils.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../../const/string.dart';
import '../../../public_features/widget/snack_bar.dart';
import '../../../public_features/widget/text_field_price_widget.dart';
import '../../../residence_features/widget/elevated_btn_widget.dart';
import '../../dashboard_features/widget/app_bar_host.dart';
import '../model/all_date_model.dart';
import '../widget/date_picker_helper.dart';

class HostPersianDatePickerScreen extends StatefulWidget {
  const HostPersianDatePickerScreen({super.key});

  @override
  State<HostPersianDatePickerScreen> createState() => _PersianDatePickerState();
}

class _PersianDatePickerState extends State<HostPersianDatePickerScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Jalali jalali = Jalali.now();
  Jalali currentMonth = Jalali.now();
  bool isNextMonth = false;
  final List<String> _selectedDates = [];
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  List<String> allDisplayedDates = [];
  List<String> selectedDates = [];
  List<bool> filterDates = [];

  @override
  void dispose() {
    priceController.dispose();
    discountController.dispose();
    super.dispose();
  }

  void _toggleMonth() {
    setState(() {
      if (isNextMonth) {
        currentMonth = Jalali.now();
      } else {
        currentMonth = Jalali(jalali.year, jalali.month + 1);
      }
      isNextMonth = !isNextMonth;
      res();
    });
  }

  bool isDateInAllDateModel(String date, List<AllDateModel> allDateModel) {
    for (var model in allDateModel) {
      if (model.date == date.replaceAll('-', '/')) {
        return true;
      }
    }
    return false;
  }

  void res() {
    allDisplayedDates.clear();
    int remainingDays =
        currentMonth.monthLength - (isNextMonth ? 0 : currentMonth.day - 1);
    for (int i = 0; i < remainingDays; i++) {
      final int displayedDay = (isNextMonth ? 1 : currentMonth.day) + i;
      final String displayedDate =
      Utils.formatDate(currentMonth.year, currentMonth.month, displayedDay);
      allDisplayedDates.add(displayedDate);
    }
    setState(() {
      filterDates = allDisplayedDates.map((item) {
        return selectedDates.contains(item);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => SendDatePickerResidenceBloc(CalenderRepository())
          ..add(CallGetRegisterResidenceUserEvent(
              id: KeySendDataHost.idHostSubmitResidence.toString())),
        child: Scaffold(
          appBar: const AppBarHost(title: 'ثبت اقامتگاه'),
          resizeToAvoidBottomInset: false,
          body: BlocListener<SendDatePickerResidenceBloc,
              SendDatePickerResidenceState>(
            listener: (context, state) {
              if (state is GetRegisterResidenceUserCompleted) {
                setState(() {
                  selectedDates =
                      context.read<SendDatePickerResidenceBloc>().result;
                  res();
                });
              } else if (state is SendDatePickerResidenceErrorState) {
                getSnackBarWidget(
                    context, state.errorMessage.toString(), Colors.red);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context, 0.03),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Utils.format(currentMonth),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                IconButton(
                                  onPressed: _toggleMonth,
                                  icon: Icon(isNextMonth
                                      ? Icons.arrow_back
                                      : Icons.arrow_forward),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.sp),
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: allDisplayedDates.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 3,
                              ),
                              itemBuilder: (context, index) {
                                final String date = allDisplayedDates[index];
                                final bool isSelected =
                                _selectedDates.contains(date);
                                final bool isInAllDateModel =
                                isDateInAllDateModel(
                                  date,
                                  context
                                      .read<SendDatePickerResidenceBloc>()
                                      .allDateModel,
                                );

                                return GestureDetector(
                                  onTap: () {
                                    if (!isInAllDateModel) {
                                      setState(() {
                                        _selectedDates.clear();
                                        _selectedDates.add(date);
                                      });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? primaryColor
                                          : (isInAllDateModel
                                          ? Colors.red
                                          : Colors.transparent),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      date,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 10.sp,
                                        fontFamily: 'dana',
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            Utils.titleTextField('قیمت اقامتگاه'),
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
                            Utils.titleTextField('تخفیف اقامتگاه'),
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
                            BlocConsumer<SendDatePickerResidenceBloc,
                                SendDatePickerResidenceState>(
                              listener: (context, state) {
                                if (state
                                is SendDatePickerResidenceCompletedState) {
                                  getSnackBarWidget(context,
                                      state.success.toString(), Colors.green);
                                }

                                if (state
                                is SendDatePickerResidenceErrorState) {
                                  getSnackBarWidget(
                                      context,
                                      state.errorMessage.toString(),
                                      Colors.red);
                                }
                              },
                              builder: (context, state) {
                                if (state
                                is SendDatePickerResidenceLoadingState) {
                                  return const Center(
                                      child: SpinKitFadingCube(
                                        color: primaryColor,
                                        size: 40.0,
                                      ));
                                }

                                return ElevatedBtnWidget(
                                    title: 'ثبت تاریخ',
                                    func: () {
                                      if (_globalKey.currentState!.validate()) {
                                        if (_selectedDates.isEmpty ||
                                            priceController.text
                                                .trim()
                                                .isEmpty ||
                                            discountController.text
                                                .trim()
                                                .isEmpty) {
                                          getSnackBarWidget(
                                              context,
                                              'لطفا تاریخ و فیلد های قیمت و تخفیف را وارد نمایید.',
                                              Colors.red);
                                        } else {
                                          _selectedDates
                                              .add(priceController.text.trim());
                                          _selectedDates.add(
                                              discountController.text.trim());
                                          priceController.clear();
                                          discountController.clear();

                                          context
                                              .read<
                                              SendDatePickerResidenceBloc>()
                                              .add(CallSendDatePickerResidenceEvent(
                                              date: _selectedDates[0]
                                                  .replaceAll('/', '-')
                                                  .toString(),
                                              accommodation: KeySendDataHost
                                                  .idHostSubmitResidence,
                                              defaultPrice: int.parse(
                                                  _selectedDates[1]
                                                      .replaceAll(',', '')),
                                              discountPercentage: int.parse(
                                                  _selectedDates[2])));
                                          context
                                              .read<
                                              SendDatePickerResidenceBloc>()
                                              .add(
                                              CallGetRegisterResidenceUserEvent(
                                                  id: KeySendDataHost
                                                      .idHostSubmitResidence
                                                      .toString()));
                                          _selectedDates.clear();
                                        }
                                      }
                                    });
                              },
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            BlocBuilder<SendDatePickerResidenceBloc,
                                SendDatePickerResidenceState>(
                              builder: (context, state) {
                                return buildDateGrid(
                                    context,
                                    state,
                                    KeySendDataHost.idHostSubmitResidence
                                        .toString());
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
