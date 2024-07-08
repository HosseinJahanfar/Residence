import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:residence/route/names.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../comment_features/widget/text_form_field_multi_line.dart';
import '../../public_features/functions/secure_storage.dart';
import '../../public_features/widget/snack_bar.dart';
import '../logic/auth_bloc.dart';
import '../services/auth_repository.dart';
import '../widget/textformfield_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.title});

  final String? title;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _acceptCodeController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _phoneEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocProvider(
            create: (context) => AuthBloc(AuthRepository()),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthErrorState) {
                  getSnackBarWidget(context, state.errorMessage, Colors.red);
                }
                if (state is AuthCompletedState) {
                  SecureStorageClass().saveUserToken(state.authModel.access);
                  if (state.authModel.profileAvailable! == true) {
                    Navigator.pushNamedAndRemoveUntil(context,
                        ScreenNames.bottomNavBarScreen, (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, ScreenNames.profileScreen, (route) => false);
                  }

                  getSnackBarWidget(
                      context, 'با موفقیت وارد شدید', Colors.green);
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return Expanded(
                    child: SpinKitFadingCube(
                      color: primaryColor,
                      size: getWidth(context, 0.20),
                    ),
                  );
                }

                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Form(
                          key: _globalKey,
                          child: Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/welcome.svg',
                                  width: getAllWidth(context),
                                ),
                                Text(
                                  'ورود به اقامتگاه',
                                  style: TextStyle(
                                      fontFamily: 'bold',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.sp),
                                const Text(
                                  'برای دریافت پیشنهاد های خاص و تجربه بهتر رزو ابتدا در اقامتگاه ثبت نام کن.',
                                  style: TextStyle(fontFamily: 'medium'),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(height: 20.sp),
                                TextFormFieldMobileWidget(
                                  labelText: 'شماره موبایل',
                                  icon:
                                      const Icon(Icons.phone_android_outlined),
                                  textInputAction: TextInputAction.done,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  controller: _phoneEditingController,
                                ),
                                SizedBox(height: 15.sp),
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primary2Color,
                                      fixedSize: Size(
                                        getWidth(context, 0.7),
                                        Responsive.isTablet(context) ? 60 : 45,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_globalKey.currentState!.validate()) {
                                        BlocProvider.of<AuthBloc>(context).add(
                                            CallAuthEvent(
                                                _phoneEditingController.text
                                                    .trim()));
                                      }
                                    },
                                    child: const Text(
                                      'احراز هویت',
                                      style: TextStyle(fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primary2Color,
                                      fixedSize: Size(
                                        getWidth(context, 0.7),
                                        Responsive.isTablet(context) ? 60 : 45,
                                      ),
                                    ),
                                    onPressed: () {
                                      // if (_globalKey.currentState!.validate()) {
                                      //   print("object");
                                      // }
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Container(
                                              width: getAllWidth(context),
                                              height: getWidth(context, 0.5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                20.sp),
                                                        topLeft:
                                                            Radius.circular(
                                                                20.sp)),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.sp),
                                                child: ListView(
                                                  children: [
                                                    Container(
                                                      width: getAllWidth(
                                                          context),
                                                      margin: EdgeInsets.only(
                                                          top: 20.sp),
                                                      child: Text(
                                                        'کد تایید پیامک شده:',
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                'bold'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    //!
                                                    TextFormFieldMobileWidget(
                                                      labelText: 'کد 6 رقمی خود را وارد نمایید',
                                                      icon:
                                                      const Icon(Icons.phone_android_outlined),
                                                      textInputAction: TextInputAction.done,
                                                      floatingLabelBehavior:
                                                      FloatingLabelBehavior.auto,
                                                      controller: _acceptCodeController,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            fixedSize: Size(
                                                                getAllWidth(
                                                                    context),
                                                                45),
                                                            backgroundColor:
                                                                primaryColor),
                                                        onPressed: () {
                                                          if (_globalKey
                                                              .currentState!
                                                              .validate()) {}
                                                        },
                                                        child: Text(
                                                          'ثبت دیدگاه',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'bold',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 12.sp,
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'باتن شیت',
                                      style: TextStyle(fontFamily: 'bold'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
