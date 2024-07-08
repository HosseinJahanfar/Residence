import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../const/connection.dart';
import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../logic/cubit/home_cubit.dart';
import '../model/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselSliderWidget extends StatelessWidget {
  CarouselSliderWidget({
    super.key,
    required this.homeModel,
  });

  final CarouselController carouselController = CarouselController();

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return homeModel.sliders == null
        ? const SizedBox.shrink()
        : BlocProvider(
            create: (context) => HomeCubit(),
            child: BlocBuilder<HomeCubit, int>(
              builder: (context, state) {
                return Column(
                  children: [
                    CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: homeModel.sliders!.length,
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          onTap: () async {
                            final url = homeModel.sliders![index].link;
                            if (await canLaunchUrlString(url!)) {
                              await launchUrlString(url,
                                  mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Container(
                            width: getAllWidth(context),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: ClipRRect(
                                borderRadius: getBorderRadiusFunc(7.5),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '$baseUrl${homeModel.sliders![index].image!}',
                                  placeholder: (context, url) => Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/logo.png',
                                    width: getWidth(context, 1),
                                  ),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: Responsive.isTablet(context)
                            ? getWidth(context, 0.33)
                            : getWidth(context, 0.43),
                        viewportFraction: 0.95,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          context.read<HomeCubit>().changeSliders(index);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    AnimatedSmoothIndicator(
                      onDotClicked: (index) {
                        context.read<HomeCubit>().changeSliders(index);
                        carouselController.animateToPage(index);
                      },
                      activeIndex: context.read<HomeCubit>().indexSlider,
                      count: homeModel.sliders!.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: primary2Color,
                        dotWidth: Responsive.isTablet(context) ? 5.sp : 8.5.sp,
                        dotHeight: Responsive.isTablet(context) ? 5.sp : 8.5.sp,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
