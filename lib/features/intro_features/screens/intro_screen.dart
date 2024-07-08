import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../const/responsive.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../../route/names.dart';
import '../logic/intro_cubit.dart';
import '../pref/shared_pref.dart';
import '../widget/page_view_widget.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  final PageController pageController = PageController(initialPage: 0);

  final List<Widget> pageItem = [
    const PageViewItems(
      image: 'assets/images/intro/1.png',
      title: '20,000 اقامتگاه فعال',
      description: 'انتخاب و مقایسه اقامتگاه ها در سراسر ایران',
    ),
    const PageViewItems(
      image: 'assets/images/intro/2.png',
      title: '500,000 نظر ثبت شده',
      description: 'بررسی اقامتگاه از دیدگاه مهمانان قبلی اقامتگاه',
    ),
    const PageViewItems(
      image: 'assets/images/intro/3.png',
      title: 'پشتیبانی 24 ساعته',
      description: 'پشتیبانی از لحظه جستجو تا پایان اقامت',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
        create: (context) => IntroCubit(),
        child: BlocBuilder<IntroCubit, int>(
          builder: (context, state) {
            return Column(
              children: [
                //*intro
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    width: getAllWidth(context),
                    height: Responsive.isDesktop(context)
                        ? 500
                        : Responsive.isTablet(context)
                            ? 400
                            : 300,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: pageItem.length,
                      itemBuilder: (context, index) => pageItem[index],
                      onPageChanged: (value) {
                        BlocProvider.of<IntroCubit>(context).changePage(value);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: pageItem.length,
                    textDirection: TextDirection.rtl,
                    onDotClicked: (index) {
                      pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    effect: const JumpingDotEffect(
                      dotWidth: 12,
                      dotHeight: 12,
                      spacing: 5,
                      activeDotColor: primary2Color,
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.sp, vertical: 15.sp),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary2Color,
                          fixedSize: Size(getAllWidth(context), 40),
                        ),
                        onPressed: () {
                          if (BlocProvider.of<IntroCubit>(context)
                                  .currentIndex <
                              2) {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          } else {
                            SharedPerf().setIntroStatus();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              ScreenNames.authScreen,
                              (route) => false,
                            );
                          }
                        },
                        child: Text(
                          context.read<IntroCubit>().currentIndex < 2
                              ? 'ورق بزنید'
                              : 'بزن بریم',
                          style: const TextStyle(
                            fontFamily: 'bold',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}
