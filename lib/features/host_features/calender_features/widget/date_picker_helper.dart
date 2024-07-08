// date_picker_helper.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/host_features/calender_features/logic/send_date_picker_residence/send_date_picker_residence_bloc.dart';
import 'package:residence/features/host_features/calender_features/model/all_date_model.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import '../../../public_features/widget/error_screen_widget.dart';
import '../utils/utils.dart';

Widget buildDateGrid(BuildContext context, SendDatePickerResidenceState state,
    String arguments) {
  if (state is GetRegisterResidenceUserLoading) {
    return const Center(
      child: SpinKitFadingCube(
        color: primaryColor,
        size: 40.0,
      ),
    );
  }

  if (state is GetRegisterResidenceUserCompleted) {
    List<AllDateModel> helper = state.allDateModel;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: helper.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        childAspectRatio: 3.5,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 5.sp),
          child: Row(
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Utils.showDetail(helper[index].date!),
                      const SizedBox(height: 4.0),
                      Utils.showDetail('${helper[index].defaultPrice} تومان'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: helper[index].discountPercentage == 0
                    ? const SizedBox.shrink()
                    : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 1.5.sp),
                        decoration: BoxDecoration(
                          borderRadius: getBorderRadiusFunc(5),
                          color: Colors.red,
                        ),
                        child: Text(
                          '${helper[index].discountPercentage}%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontFamily: 'bold',
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: helper[index].isEditableAndDeletable!
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            onPressed: () {
                              BlocProvider.of<SendDatePickerResidenceBloc>(
                                      context)
                                  .add(CallDeleteDatePickerResidenceEvent(
                                      id: helper[index].id.toString(),
                                      index: index));
                            },
                            icon: Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                              size: 26.sp,
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            onPressed: () {
                              getSnackBarWidget(
                                  context,
                                  'این تاریخ رو شما نمی توانید تغییر دهید.',
                                  Colors.red);
                            },
                            icon: Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.grey,
                              size: 26.sp,
                            ),
                          ),
                        )),
            ],
          ),
        );
      },
    );
  }

  if (state is GetRegisterResidenceUserError) {
    return ErrorScreenWidget(
      errorMsg: state.errorMessage.toString(),
      function: () {
        context.read<SendDatePickerResidenceBloc>().add(
              CallGetRegisterResidenceUserEvent(
                id: arguments.toString(),
              ),
            );
      },
    );
  }

  return const SizedBox.shrink();
}
