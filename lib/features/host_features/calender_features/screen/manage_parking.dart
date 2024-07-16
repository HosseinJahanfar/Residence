import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/features/host_features/calender_features/services/calender_repository.dart';
import 'package:residence/features/public_features/widget/error_screen_widget.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import 'package:residence/features/residence_features/widget/elevated_btn_widget.dart';

import '../../../../const/shape/media_query.dart';
import '../../../../const/string.dart';
import '../../../../const/theme/colors.dart';
import '../../../public_features/widget/text_field_price_widget.dart';
import '../../dashboard_features/widget/app_bar_host.dart';
import '../logic/register_parking_user/edit_parking_user_bloc.dart';
import '../logic/send_edit_parking/send_edit_parking_bloc.dart';
import '../utils/utils.dart';

class ManageParking extends StatefulWidget {
  const ManageParking({super.key});

  @override
  State<ManageParking> createState() => _ManageParkingState();
}

class _ManageParkingState extends State<ManageParking> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _emptyController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<EditParkingUserBloc>(context).add(CallEditParkingUserEvent(
        id: KeySendDataHost.idHostSubmitParking.toString()));
    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _emptyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarHost(title: 'ثبت پارکینگ'),
      body: BlocBuilder<EditParkingUserBloc, EditParkingUserState>(
        builder: (context, state) {
          if (state is EditParkingUserLoading) {
            return const Center(
                child: SpinKitFadingCube(
              color: primaryColor,
              size: 40.0,
            ));
          }

          if (state is EditParkingUserCompleted) {
            var helper = state.editParkingModel;
            _priceController.text = helper.price.toString();
            _emptyController.text = helper.remainingCapacity.toString();
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getWidth(context, 0.03),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.sp,
                  ),
                  Utils.titleTextField('قیمت روزانه هر جایگاه'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  InputTextFieldPriceWidget(
                    hintText: "لطفاً قیمت پارکینگ خود را وارد کنید.",
                    textInputAction: TextInputAction.next,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _priceController,
                    maxLength: 12,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Utils.titleTextField('فضای خالی پارکینگ'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  InputTextFieldDiscountWidget(
                    hintText: "لطفا تعداد خالی بودن پارکینگ را وارد نمایید.",
                    textInputAction: TextInputAction.done,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _emptyController,
                    maxLength: 3,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  BlocProvider(
                    create: (context) =>
                        SendEditParkingBloc(CalenderRepository()),
                    child:
                        BlocConsumer<SendEditParkingBloc, SendEditParkingState>(
                      listener: (context, state) {
                        if (state is SendEditParkingUserError) {
                          getSnackBarWidget(context,
                              state.errorMessage.toString(), Colors.red);
                        }

                        if (state is SendEditParkingUserCompleted) {
                          getSnackBarWidget(
                              context, state.msg.toString(), Colors.green);
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        if (state is SendEditParkingUserLoading) {
                          const Center(
                              child: SpinKitFadingCube(
                            color: primaryColor,
                            size: 40.0,
                          ));
                        }
                        return ElevatedBtnWidget(
                          title: 'ثبت اطلاعات',
                          func: () {
                            context.read<SendEditParkingBloc>().add(
                                CallSendEditParkingUserEvent(
                                    id: KeySendDataHost.idHostSubmitParking
                                        .toString(),
                                    remainingCapacity: _emptyController.text.trim().toString(),
                                    price: _priceController.text.trim().toString().replaceAll(',', '')));
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }

          if (state is EditParkingUserError) {
            return ErrorScreenWidget(
                errorMsg: state.errorMessage.toString(),
                function: () {
                  BlocProvider.of<EditParkingUserBloc>(context).add(
                      CallEditParkingUserEvent(
                          id: KeySendDataHost.idHostSubmitParking.toString()));
                });
          }

          return const SizedBox.shrink();
        },
      ),
    ));
  }
}
