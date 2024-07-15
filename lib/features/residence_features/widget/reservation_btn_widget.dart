import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import 'package:residence/features/residence_features/model/residence_detail_model.dart';
import 'package:residence/features/residence_features/widget/outline_btn_widget.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';
import '../logic/residence_bloc.dart';

class ReservationBtnWidget extends StatefulWidget {
  const ReservationBtnWidget({super.key, required this.helperDetail});

  final ResidenceDetailModel helperDetail;

  @override
  State<ReservationBtnWidget> createState() => _ReservationBtnWidgetState();
}

class _ReservationBtnWidgetState extends State<ReservationBtnWidget> {
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
                  widget.helperDetail.discountPercentage == 0
                      ? const SizedBox.shrink()
                      : Text(
                          getPriceFormat(
                              widget.helperDetail.percentPrice.toString()),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12.sp),
                        ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  //!box-percentage
                  widget.helperDetail.discountPercentage == 0
                      ? const SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5.sp, horizontal: 5.sp),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 2),
                              color: Colors.red,
                              borderRadius: getBorderRadiusFunc(50.sp)),
                          child: Text(
                            '${widget.helperDetail.discountPercentage.toString()}%',
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
                        'شروع قیمت ${getPriceFormat(widget.helperDetail.defaultPrice.toString())} تومان',
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
                  int totalPrice = 0;
                  int percentPrice = 0;
                  int sufferDiscount = 0;
                  int counter = 1;
                  int countPerson = 0;

                  for (var element in KeySendDataHost.defaultPrice) {
                    totalPrice += element;
                  }
                  for (var element in KeySendDataHost.percentPrice) {
                    percentPrice += element;
                  }
                  //!discount percent
                  sufferDiscount = (totalPrice - percentPrice);

                  showModalBottomSheet(
                    isDismissible: false,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.sp),
                                child: SingleChildScrollView(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //!circle container
                                    Center(
                                      child: Container(
                                        width: 100.sp,
                                        height: 5,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                getBorderRadiusFunc(1000)),
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        const Icon(AntDesign.calendar),
                                        SizedBox(
                                          width: 2.5.sp,
                                        ),
                                        SizedBox(
                                          height: 2.5.sp,
                                        ),
                                        Text(
                                            ' رزو ${KeySendDataHost.sendDates.length} روز')
                                      ],
                                    ),

                                    SizedBox(
                                      height: 15.sp,
                                    ),
                                    //! Section 1
                                    SizedBox(
                                      width: getAllWidth(context),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Row(
                                              children: [
                                                const Icon(Fontisto.persons),
                                                SizedBox(
                                                  width: 10.sp,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'تعداد مسافران',
                                                      style: TextStyle(
                                                          fontFamily: 'medium',
                                                          color: Colors
                                                              .grey.shade500),
                                                    ),
                                                    Text(
                                                      '${counter.toString()} نفر',
                                                      style: const TextStyle(
                                                        fontFamily: 'medium',
                                                      ),
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                counter ==
                                                        widget.helperDetail
                                                            .maximumCapacity
                                                    ? OutlineBtnWidget(
                                                        iconData:
                                                            AntDesign.plus,
                                                        func: null,
                                                        colors: Colors
                                                            .grey.shade300,
                                                      )
                                                    : OutlineBtnWidget(
                                                        iconData:
                                                            AntDesign.plus,
                                                        func: () {
                                                          setState(() {
                                                            counter += 1;
                                                          });
                                                          if (counter >
                                                              widget
                                                                  .helperDetail
                                                                  .minimumCapacity!) {
                                                            countPerson = (counter -
                                                                widget
                                                                    .helperDetail
                                                                    .minimumCapacity!);
                                                          }
                                                        },
                                                        colors: Colors.black,
                                                      ),
                                                Text(
                                                  counter.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                  ),
                                                  textDirection:
                                                      TextDirection.ltr,
                                                ),
                                                counter == 1
                                                    ? OutlineBtnWidget(
                                                        iconData: Entypo.minus,
                                                        func: null,
                                                        colors: Colors
                                                            .grey.shade300,
                                                      )
                                                    : OutlineBtnWidget(
                                                        iconData: Entypo.minus,
                                                        func: () {
                                                          setState(() {
                                                            counter -= 1;
                                                          });

                                                          if (counter >=
                                                              widget
                                                                  .helperDetail
                                                                  .minimumCapacity!) {
                                                            countPerson--;
                                                          }
                                                        },
                                                        colors: Colors.black,
                                                      )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    //!Section 2
                                    Text(
                                      'خلاصه پرداخت',
                                      style: TextStyle(
                                          fontFamily: 'bold', fontSize: 14.sp),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${KeySendDataHost.sendDates.length.toString()} شب اقامتگاه',
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12.sp),
                                        ),
                                        Text(
                                          '${getPriceFormat(totalPrice.toString())} تومان',
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${countPerson.toString()} نفر اضافه',
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12.sp),
                                        ),
                                        Text(
                                          '${getPriceFormat((countPerson * widget.helperDetail.additionalPersonPrice!).toString())} تومان',
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'میزان تخفیف',
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12.sp),
                                        ),
                                        Text(
                                          '${getPriceFormat(sufferDiscount.toString())} تومان',
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'جمع مبلغ قابل پرداخت',
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12.sp),
                                        ),
                                        Text(
                                          '${getPriceFormat(((totalPrice + (countPerson * widget.helperDetail.additionalPersonPrice!)) - sufferDiscount).toString())} تومان',
                                          style: TextStyle(
                                              fontFamily: 'normal',
                                              fontSize: 12.sp),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 20.sp,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          getBorderRadiusFunc(
                                                              5)),
                                                  backgroundColor:
                                                      Colors.grey.shade300),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "بستن",
                                                style: TextStyle(
                                                    fontFamily: 'medium',
                                                    color: Colors.black),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: BlocConsumer<ResidenceBloc,
                                              ResidenceState>(
                                            listener: (context, state) {
                                              if (state is ReserveDaysError) {
                                                getSnackBarWidget(
                                                    context,
                                                    state.error.toString(),
                                                    Colors.red);
                                              }

                                              if (state
                                                  is ReserveDaysCompleted) {
                                                Navigator.pop(context);
                                                getSnackBarWidget(
                                                    context,
                                                    state.message.toString(),
                                                    Colors.green);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is ReserveDaysLoading) {
                                                return const Center(
                                                    child: SpinKitFadingCube(
                                                      color: primaryColor,
                                                      size: 30.0,
                                                    ));
                                              }

                                              return ElevatedButton(
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                    backgroundColor:
                                                        primary2Color,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            getBorderRadiusFunc(
                                                                5)),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<ResidenceBloc>()
                                                        .add(CallReserveDaysEvent(
                                                            daysId:
                                                                KeySendDataHost
                                                                    .idDate,
                                                            numPeople: counter
                                                                .toString()));
                                                  },
                                                  child: const Text(
                                                    "پرداخت",
                                                    style: TextStyle(
                                                        fontFamily: 'medium',
                                                        color: Colors.white),
                                                  ));
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                              )),
                        );
                      });
                    },
                  );
                }
              },
              child: const Text(
                'رزرو اقامتگاه',
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
