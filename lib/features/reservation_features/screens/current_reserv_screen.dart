import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:residence/features/public_features/widget/error_screen_widget.dart';
import 'package:residence/features/reservation_features/model/reservation_model.dart';
import 'package:residence/features/reservation_features/services/reservation-repository.dart';
import 'package:residence/features/reservation_features/services/reservation_api_services.dart';
import '../../../const/connection.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../logic/reservation_bloc.dart';

class CurrentReservation extends StatelessWidget {
  const CurrentReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReservationBloc(ReservationRepository())..add(CallReservationEvent()),
      child: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
          if (state is ReservationLoading) {
            return const Center(
                child: SpinKitFadingCube(
              color: primaryColor,
              size: 40.0,
            ));
          }

          if (state is ReservationCompleted) {
            ReservationModel helper = state.reservationModel;
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 5.sp),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: helper.currentReservations!.length,
                    (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.sp, horizontal: 10.sp),
                        child: Container(
                          width: getAllWidth(context),
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: getBorderRadiusFunc(5)),
                          child: Row(
                            children: [
                              //! sliver pictures
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: getAllWidth(context),
                                  height: getAllHeight(context),
                                  child: ClipRRect(
                                    borderRadius: getBorderRadiusFunc(5),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '$baseUrl${helper.currentReservations![index].accommodationFirstImage}',
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/logo.png',
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const SizedBox.shrink(),
                                        fit: BoxFit.contain,
                                      ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/images/logo.png',
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const SizedBox.shrink(),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    width: getAllWidth(context),
                                    color: Colors.transparent,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getWidth(context, 0.04),
                                        vertical: getWidth(context, 0.02)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          helper.currentReservations![index]
                                              .accommodationTitle!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'bold',
                                              fontSize: 11.sp),
                                          maxLines: 1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                '${helper.currentReservations![index].numDays} شب',
                                                style: TextStyle(
                                                    color: Colors.grey.shade500,
                                                    fontFamily: 'medium',
                                                    fontSize: 10.sp)),
                                            helper.currentReservations![index]
                                                        .numDays ==
                                                    1
                                                ? Text(
                                                    'تاریخ : ${helper.currentReservations![index].startDate}',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontFamily: 'medium',
                                                        fontSize: 10.sp))
                                                : Text(
                                                    'شروع از : ${helper.currentReservations![index].startDate}',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontFamily: 'medium',
                                                        fontSize: 10.sp))
                                          ],
                                        ),
                                        //!btn delete favorite
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            height: 30.0,
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                overlayColor: Colors.red,
                                                side: const BorderSide(
                                                    color: Colors.red),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        getBorderRadiusFunc(5)),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getWidth(context, 0.08)
                                                            .sp),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              onPressed: () {

                                                context
                                                    .read<ReservationBloc>()
                                                    .add(CancelReservationEvent(
                                                        helper
                                                            .currentReservations![
                                                                index]
                                                            .id!.toString()));
                                              },
                                              child: Text(
                                                'لغو سفر',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'bold',
                                                  fontSize: 9
                                                      .sp, // تنظیم اندازه فونت کوچک‌تر
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  )),
                )
              ],
            );
          }

          if (state is ReservationError) {
            return ErrorScreenWidget(
                errorMsg: state.errorMessage.toString(),
                function: () {
                  BlocProvider.of<ReservationBloc>(context)
                      .add(CallReservationEvent());
                });
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
