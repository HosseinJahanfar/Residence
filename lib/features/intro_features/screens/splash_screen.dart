import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../const/responsive.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../../public_features/logic/token_check/token_check_cubit.dart';
import '../pref/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //methode change page intro or home
  navigate() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        if (await SharedPerf().getHostStatus()) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            ScreenNames.bottomNavBarHostScreen,
                (route) => false,
          );

        } else {
          if (await SharedPerf().getIntroStatus()) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              ScreenNames.checkHome,
              (route) => false,
            );
          } else {
            Navigator.of(context).pushReplacementNamed(ScreenNames.introScreen);
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TokenCheckCubit>(context).tokenCheck();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary2Color,
        body: Center(
          child: FadeInDown(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: isDesktop
                      ? getWidth(context, 0.05)
                      : getWidth(context, 0.26),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: isDesktop
                        ? getWidth(context, 0.05)
                        : getAllWidth(context),
                  ),
                ),
                SizedBox(
                  height: 30.sp,
                ),
                const SpinKitFadingCube(
                  color: Colors.white,
                  size: 40.0,
                ),
                SizedBox(
                  height: 30.sp,
                ),
                Text(
                  'ProKala',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: isDesktop ? 14.sp : 18.sp,
                    fontFamily: 'bold',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  'www.programmingshow.ir',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: isDesktop ? 10.sp : 14.sp,
                    fontFamily: 'bold',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
