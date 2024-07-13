import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../const/connection.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/widget/error_screen_widget.dart';
import '../logic/reservation_bloc.dart';
import '../model/reservation_model.dart';
import '../services/reservation-repository.dart';

class PreviousReservation extends StatelessWidget {
  const PreviousReservation({super.key});

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
                    childCount: helper.pastReservations!.length,
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
                                                '$baseUrl${helper.pastReservations![index].accommodationFirstImage}',
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/logo.png',
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const SizedBox.shrink(),
                                              fit: BoxFit.contain,
                                            ),
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/images/logo.png',
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
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
                                              horizontal:
                                                  getWidth(context, 0.04),
                                              vertical:
                                                  getWidth(context, 0.02)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                helper.pastReservations![index]
                                                    .accommodationTitle!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'bold',
                                                    fontSize: 11.sp),
                                                maxLines: 1,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      '${helper.pastReservations![index].numDays} شب',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade500,
                                                          fontFamily: 'medium',
                                                          fontSize: 10.sp)),
                                                  helper
                                                              .pastReservations![
                                                                  index]
                                                              .numDays ==
                                                          1
                                                      ? Text(
                                                          'تاریخ : ${helper.pastReservations![index].startDate}',
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade500,
                                                              fontFamily:
                                                                  'medium',
                                                              fontSize: 10.sp))
                                                      : Text(
                                                          'شروع از : ${helper.pastReservations![index].startDate}',
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade500,
                                                              fontFamily:
                                                                  'medium',
                                                              fontSize: 10.sp))
                                                ],
                                              ),
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
