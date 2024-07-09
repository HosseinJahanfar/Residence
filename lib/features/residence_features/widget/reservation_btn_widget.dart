import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import 'package:residence/features/residence_features/model/residence_detail_model.dart';
import 'package:residence/features/residence_features/widget/outline_btn_widget.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';

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
                }else{
                  print(KeySendDataHost.sendDates.length);

                }
                // print(selectedDates);
                // showModalBottomSheet(
                //   context: context,
                //   builder: (context) {
                //     return Padding(
                //       padding: EdgeInsets.only(
                //           bottom: MediaQuery.of(context).viewInsets.bottom),
                //       child: Container(
                //         width: getAllWidth(context),
                //         height: getWidth(context, 1),
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.only(
                //               topRight: Radius.circular(20.sp),
                //               topLeft: Radius.circular(20.sp)),
                //         ),
                //         child: Padding(
                //             padding: EdgeInsets.symmetric(horizontal: 10.sp),
                //             child: SingleChildScrollView(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   //!circle container
                //                   Center(
                //                     child: Container(
                //                       width: 100.sp,
                //                       height: 5,
                //                       margin:
                //                           EdgeInsets.symmetric(vertical: 10.sp),
                //                       decoration: BoxDecoration(
                //                           color: Colors.grey.shade300,
                //                           borderRadius:
                //                               getBorderRadiusFunc(1000)),
                //                     ),
                //                   ),
                //
                //                   Row(
                //                     children: [
                //                       const Icon(AntDesign.calendar),
                //                       SizedBox(
                //                         width: 2.5.sp,
                //                       ),
                //                       Text(
                //                           ' رزو ${KeySendDataHost.sendDates.length} روز')
                //                     ],
                //                   ),
                //
                //                   SizedBox(
                //                     height: 15.sp,
                //                   ),
                //                   //! Section 1
                //                   SizedBox(
                //                     width: getAllWidth(context),
                //                     child: Row(
                //                       children: [
                //                         Expanded(
                //                           flex: 4,
                //                           child: Row(
                //                             children: [
                //                               const Icon(Fontisto.persons),
                //                               SizedBox(
                //                                 width: 10.sp,
                //                               ),
                //                               Column(
                //                                 crossAxisAlignment:
                //                                     CrossAxisAlignment.start,
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment
                //                                         .spaceBetween,
                //                                 children: [
                //                                   Text(
                //                                     'تعداد مسافران',
                //                                     style: TextStyle(
                //                                         fontFamily: 'medium',
                //                                         color: Colors
                //                                             .grey.shade500),
                //                                   ),
                //                                   const Text('9نفر',
                //                                       style: TextStyle(
                //                                         fontFamily: 'medium',
                //                                       ))
                //                                 ],
                //                               )
                //                             ],
                //                           ),
                //                         ),
                //                         Expanded(
                //                           flex: 2,
                //                           child: Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.spaceEvenly,
                //                             children: [
                //                               OutlineBtnWidget(
                //                                 iconData: AntDesign.plus,
                //                                 func: () {},
                //                               ),
                //                               Text(
                //                                 '1',
                //                                 style:
                //                                     TextStyle(fontSize: 12.sp),
                //                               ),
                //                               OutlineBtnWidget(
                //                                 iconData: Entypo.minus,
                //                                 func: () {},
                //                               ),
                //                             ],
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     height: 10.sp,
                //                   ),
                //                   Divider(
                //                     height: 1,
                //                     color: Colors.grey.shade300,
                //                   ),
                //                   SizedBox(
                //                     height: 10.sp,
                //                   ),
                //                   //!Section 2
                //                   Text(
                //                     'خلاصه پرداخت',
                //                     style: TextStyle(
                //                         fontFamily: 'bold', fontSize: 14.sp),
                //                   ),
                //                   SizedBox(
                //                     height: 10.sp,
                //                   ),
                //                   const Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Text(
                //                         '3 شب اقمتگاه',
                //                       ),
                //                       Text('data'),
                //                     ],
                //                   ),
                //                   SizedBox(
                //                     height: 10.sp,
                //                   ),
                //
                //                   const Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Text('data'),
                //                       Text('data'),
                //                     ],
                //                   ),
                //                   SizedBox(
                //                     height: 10.sp,
                //                   ),
                //
                //                   Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Text('data'),
                //                       Text('data'),
                //                     ],
                //                   ),
                //                   SizedBox(
                //                     height: 10.sp,
                //                   ),
                //                   Divider(
                //                     height: 1,
                //                     color: Colors.grey.shade300,
                //                   ),
                //                   SizedBox(
                //                     height: 10.sp,
                //                   ),
                //
                //                   const Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Text('data'),
                //                       Text('data'),
                //                     ],
                //                   ),
                //
                //                   SizedBox(
                //                     height: 20.sp,
                //                   ),
                //                   Divider(
                //                     height: 1,
                //                     color: Colors.grey.shade300,
                //                   ),
                //                   SizedBox(
                //                     height: 10.sp,
                //                   ),
                //                   Row(
                //                     children: [
                //                       Expanded(
                //                         flex: 2,
                //                         child: ElevatedButton(
                //                             style: ElevatedButton.styleFrom(
                //                                 shape: RoundedRectangleBorder(
                //                                     borderRadius:
                //                                         getBorderRadiusFunc(5)),
                //                                 backgroundColor:
                //                                     Colors.grey.shade300),
                //                             onPressed: () {},
                //                             child: const Text(
                //                               "بستن",
                //                               style: TextStyle(
                //                                   fontFamily: 'medium',
                //                                   color: Colors.black),
                //                             )),
                //                       ),
                //                       const SizedBox(
                //                         width: 5,
                //                       ),
                //                       Expanded(
                //                         flex: 4,
                //                         child: ElevatedButton(
                //                             style: ElevatedButton.styleFrom(
                //                               backgroundColor: primary2Color,
                //                               shape: RoundedRectangleBorder(
                //                                   borderRadius:
                //                                       getBorderRadiusFunc(5)),
                //                             ),
                //                             onPressed: () {},
                //                             child: const Text(
                //                               "ادامه رزرو",
                //                               style: TextStyle(
                //                                   fontFamily: 'medium',
                //                                   color: Colors.white),
                //                             )),
                //                       ),
                //                     ],
                //                   )
                //                 ],
                //               ),
                //             )),
                //       ),
                //     );
                //   },
                // );
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
