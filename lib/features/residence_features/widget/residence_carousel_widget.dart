import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/features/favorite_features/logic/favorite_bloc.dart';
import 'package:residence/features/favorite_features/services/favorite_repository.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../const/connection.dart';
import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../logic/cubit/residence_cubit.dart';
import '../model/residence_detail_model.dart';

class ResidenceCarouselSlider extends StatelessWidget {
  ResidenceCarouselSlider({
    super.key,
    required this.helperDetail,
    required this.carouselController,
    required this.argumentId,
    required this.favoriteStatus,
  });

  final ResidenceDetailModel helperDetail;
  final CarouselController carouselController;
  final String argumentId;
  bool favoriteStatus;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: helperDetail.image!.length,
          carouselController: carouselController,
          itemBuilder: (context, index, realIndex) {
            var helperIndex = helperDetail.image![index];
            return CachedNetworkImage(
              imageUrl: '$baseUrl$helperIndex',
              width: getAllWidth(context),
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/logo.png',
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
              placeholder: (context, url) => Image.asset(
                'assets/images/logo.png',
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
                fit: BoxFit.contain,
              ),
            );
          },
          options: CarouselOptions(
            height: Responsive.isTablet(context)
                ? getWidth(context, 0.4)
                : getWidth(context, 0.75),
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              context.read<ResidenceCubit>().changeIndex(index);
            },
          ),
        ),
        //!
        Positioned(
            top: 0,
            child: Container(
              width: getAllWidth(context),
              padding: EdgeInsets.all(8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: getBorderRadiusFunc(5.sp),
                        color: Colors.white70),
                    child: IconButton(
                        onPressed: () {
                          //!Back
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: getBorderRadiusFunc(5.sp),
                            color: Colors.white70),
                        child: IconButton(
                            onPressed: () {
                              //!share
                            },
                            icon: const Icon(Icons.share_outlined)),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      FavoriteButton(
                          favoriteStatus: favoriteStatus,
                          argumentId: argumentId),
                    ],
                  )
                ],
              ),
            )),

        //!Change Page Slider
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: getBorderRadiusFunc(20),
            ),
            child: AnimatedSmoothIndicator(
              onDotClicked: (index) {
                context.read<ResidenceCubit>().changeIndex(index);
                carouselController.animateToPage(index);
              },
              activeIndex:
                  BlocProvider.of<ResidenceCubit>(context).currentIndex,
              count: helperDetail.image!.length,
              effect: ExpandingDotsEffect(
                paintStyle: PaintingStyle.fill,
                activeDotColor: primaryColor,
                dotColor: Colors.white,
                dotWidth: Responsive.isTablet(context) ? 5.sp : 7.sp,
                dotHeight: Responsive.isTablet(context) ? 5.sp : 7.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//!FavoriteButton
class FavoriteButton extends StatelessWidget {
  FavoriteButton(
      {super.key, required this.favoriteStatus, required this.argumentId});

  final String argumentId;
  bool favoriteStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: getBorderRadiusFunc(5.sp), color: Colors.white70),
      child: BlocProvider(
        create: (context) => FavoriteBloc(FavoriteRepository()),
        child: BlocConsumer<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteErrorState) {
              getSnackBarWidget(
                  context, state.errorMessage.toString(), Colors.red);
            }
            if (state is FavoriteCompletedState) {
              if (state.status) {
                getSnackBarWidget(context, 'اقامتگاه به علاقه مند ها اضافه شد.',
                    Colors.green);
                favoriteStatus = true;
              } else {
                getSnackBarWidget(
                    context, 'اقامتگاه از علاقه مندی ها حذف شد.', Colors.red);
                favoriteStatus = false;
              }
            }
          },
          builder: (context, state) {
            if (state is FavoriteLoadingState) {
              return const Center(
                  child: SpinKitFadingCircle(
                color: Colors.red,
                size: 40.0,
              ));
            }
            return IconButton(
                onPressed: () {
                  //!favorite
                  BlocProvider.of<FavoriteBloc>(context)
                      .add(AddToFavoriteEvent(id: argumentId));
                },
                icon: favoriteStatus
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_outline));
          },
        ),
      ),
    );
  }
}
