import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/features/host_features/calender_features/model/all_date_model.dart';
import 'package:residence/features/public_features/widget/error_screen_widget.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import 'package:residence/features/residence_features/model/calculate_price_model.dart';
import 'package:residence/features/residence_features/model/residence_detail_model.dart';
import 'package:residence/features/residence_features/services/residence_repository.dart';
import 'package:residence/features/residence_features/widget/calculate_price_widget.dart';
import 'package:residence/features/residence_features/widget/outline_btn_widget.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';
import '../logic/rezerve_residence/residence_reservation_bloc.dart';

class ReservationBtnWidget extends StatelessWidget {
  const ReservationBtnWidget({super.key, required this.helperDetail});

  final ResidenceDetailModel helperDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getAllWidth(context),
      height: getWidth(context, 0.2),
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  helperDetail.discountPercentage == 0
                      ? const SizedBox.shrink()
                      : Text(
                          getPriceFormat(helperDetail.percentPrice.toString()),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12.sp),
                        ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  //!box-percentage
                  helperDetail.discountPercentage == 0
                      ? const SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5.sp, horizontal: 5.sp),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 2),
                              color: Colors.red,
                              borderRadius: getBorderRadiusFunc(50.sp)),
                          child: Text(
                            '${helperDetail.discountPercentage.toString()}%',
                            style: TextStyle(
                                fontFamily: 'bold',
                                color: Colors.white,
                                fontSize: 12.sp),
                          ),
                        ),
                ],
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text:
                        'شروع قیمت ${getPriceFormat(helperDetail.defaultPrice.toString())} تومان',
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'medium',
                    )),
                TextSpan(
                    text: '/هرشب',
                    style: TextStyle(color: greyTxtColor, fontFamily: 'bold'))
              ])),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary2Color,
              ),
              onPressed: () {
                // print('......................');
                if (KeySendDataHost.sendDates.isEmpty) {
                  getSnackBarWidget(
                      context,
                      'لطفا برای رزرو اقامتگاه یک روز رو انتخاب کنید.',
                      Colors.red);
                } else {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          width: getAllWidth(context),
                          height: getWidth(context, 1),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.sp),
                                topLeft: Radius.circular(20.sp)),
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: SingleChildScrollView(
                                child: BlocProvider(
                                  create: (context) => ResidenceReservationBloc(
                                      ResidenceDetailRepository())
                                    ..add(CallResidenceReservationEvent(
                                        dayIds: KeySendDataHost.sendDates.length
                                            .toString(),
                                        numPeople: '1')),
                                  child: BlocBuilder<ResidenceReservationBloc,
                                      ResidenceReservationState>(
                                    builder: (context, state) {
                                      if (state
                                          is ResidenceReservationLoading) {
                                        return const Center(
                                          child: SpinKitFadingCube(
                                            color: primaryColor,
                                            size: 40.0,
                                          ),
                                        );
                                      }

                                      if (state
                                          is ResidenceReservationCompleted) {
                                        CalculatePriceModel helper =
                                            state.calculatePriceModel;
                                        return CalculatePriceWidget(
                                            helper: helper);
                                      }

                                      if (state is ResidenceReservationError) {
                                        return ErrorScreenWidget(
                                            errorMsg: state.error.toString(),
                                            function: () {
                                              context
                                                  .read<
                                                      ResidenceReservationBloc>()
                                                  .add(
                                                      CallResidenceReservationEvent(
                                                          dayIds:
                                                              KeySendDataHost
                                                                  .sendDates
                                                                  .length
                                                                  .toString(),
                                                          numPeople: '1'));
                                            });
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                              )),
                        ),
                      );
                    },
                  );
                }
              },
              child: const Text(
                'رزو اقامتگاه',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'bold',
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
