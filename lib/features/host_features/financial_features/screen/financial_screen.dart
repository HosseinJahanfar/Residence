import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/features/host_features/financial_features/services/financial_repository.dart';
import 'package:residence/features/public_features/functions/number_to_three.dart';
import 'package:residence/features/public_features/widget/error_screen_widget.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';

import '../../../../const/shape/border_radius.dart';
import '../../../../const/shape/media_query.dart';
import '../../../../const/theme/colors.dart';
import '../logic/financial_bloc.dart';
import '../widget/account_number_input.dart';
import '../widget/price_input_textfield.dart';

class FinancialScreen extends StatefulWidget {
  FinancialScreen({super.key});

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<FinancialBloc>().add(CallFinancialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialBloc, FinancialState>(
      builder: (context, state) {
        if (state is FinancialLoading) {
          return const Center(
              child: SpinKitFadingCube(
            color: primaryColor,
            size: 40.0,
          ));
        }

        if (state is FinancialCompleted) {
          var helper = state.financialModel;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.02)),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: Text(
                    'مالی',
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'bold'),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Card(
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.sp),
                      child: Column(
                        children: [
                          Text(
                            '${getPriceFormat(helper.balance)} تومان',
                            style: TextStyle(
                                fontSize: 26.sp,
                                fontFamily: 'bold',
                                color: Colors.green),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Text(
                            'موجودی قابل برداشت',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'bold',
                                fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: getBorderRadiusFunc(5.sp)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getWidth(context, 0.09)),
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          width: getAllWidth(context),
                                          height: getWidth(context, 0.8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight:
                                                    Radius.circular(20.sp),
                                                topLeft:
                                                    Radius.circular(20.sp)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.sp),
                                            child: Form(
                                              key: _globalKey,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width:
                                                          getAllWidth(context),
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                          top: 20.sp),
                                                      child: Text(
                                                        'مبلغ مورد نظر',
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily:
                                                                'medium'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    //!
                                                    PriceInputTextFieldWidget(
                                                      hintText: 'مانند: 20000',
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .auto,
                                                      controller:
                                                          _priceController,
                                                      maxLength: 12,
                                                      textInputType:
                                                          TextInputType.number,
                                                    ),

                                                    Container(
                                                      width:
                                                          getAllWidth(context),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'شماره کارت',
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily:
                                                                'medium'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    //!
                                                    AccountNumberInputTextFieldWidget(
                                                      hintText:
                                                          'شماره حساب خود را وارد کنید',
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never,
                                                      controller:
                                                          _accountNumberController,
                                                      maxLength: 16,
                                                    ),
                                                    SizedBox(
                                                      height: 15.sp,
                                                    ),
                                                    BlocConsumer<FinancialBloc,
                                                        FinancialState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is MoneyError) {
                                                          getSnackBarWidget(
                                                              context,
                                                              state.errorMessage
                                                                  .toString(),
                                                              Colors.red);
                                                        }

                                                        if (state
                                                            is MoneyCompleted) {
                                                          Navigator.pop(
                                                              context);
                                                          getSnackBarWidget(
                                                              context,
                                                              state.msg
                                                                  .toString(),
                                                              Colors.green);
                                                          context.read<FinancialBloc>().add(CallFinancialEvent());



                                                        }
                                                      },
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is MoneyLoading) {
                                                          return const Center(
                                                              child:
                                                                  SpinKitFadingCube(
                                                            color: primaryColor,
                                                            size: 30.0,
                                                          ));
                                                        }
                                                        return ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                fixedSize: Size(
                                                                    getAllWidth(
                                                                        context),
                                                                    45),
                                                                elevation: 1,
                                                                backgroundColor:
                                                                    Colors
                                                                        .green),
                                                            onPressed: () {
                                                              if (_globalKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                context.read<FinancialBloc>().add(CallMoneyEvent(
                                                                    price: _priceController
                                                                        .text
                                                                        .trim()
                                                                        .replaceAll(
                                                                            ',',
                                                                            '')));

                                                              }
                                                              _priceController
                                                                  .clear();
                                                              _accountNumberController
                                                                  .clear();
                                                            },
                                                            child: Text(
                                                              'برداشت',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'bold',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ));
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                );
                              },
                              child: Text(
                                'برداشت',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'bold',
                                    fontSize: 14.sp),
                              )),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Text(
                            'کل درآمد تا کنون:${getPriceFormat(helper.totalReservationPayments)} تومان',
                            style: TextStyle(
                                fontFamily: 'medium', fontSize: 12.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: getWidth(context, 0.05)),
                    child: Center(
                        child: Text(
                      'سوابق برداشت:',
                      style: TextStyle(
                          fontFamily: 'medium',
                          color: Colors.grey.shade600,
                          fontSize: 14.sp),
                    )),
                  ),
                ),

                //!mony
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 2.5.sp),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: helper.transactions!.length,
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
                                flex: 5,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${getPriceFormat(helper.transactions![index].amount!.toString())} تومان',
                                        style: TextStyle(
                                            fontFamily: 'medium',
                                            fontSize: 14.sp,
                                            color: Colors.red),
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      Text(
                                        '${helper.transactions![index].date}',
                                        style: TextStyle(
                                            fontFamily: 'medium',
                                            color: Colors.grey.shade400),
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      helper.transactions![index].isDone!
                                          ? const Text(
                                              'وضعیت: انجام شده',
                                              style: TextStyle(
                                                  fontFamily: 'medium',
                                                  color: Colors.black54),
                                            )
                                          : const Text(
                                              'وضعیت: در انتظار پرداخت',
                                              style: TextStyle(
                                                  fontFamily: 'medium',
                                                  color: Colors.black54),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              const Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
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
            ),
          );
        }

        if (state is FinancialError) {
          return ErrorScreenWidget(
              errorMsg: state.errorMessage.toString(),
              function: () {
                BlocProvider.of<FinancialBloc>(context)
                    .add(CallFinancialEvent());
              });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
