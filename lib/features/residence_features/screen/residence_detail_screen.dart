import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:residence/features/residence_features/logic/residence_bloc.dart';
import 'package:residence/features/residence_features/services/residence_api_services.dart';
import 'package:residence/features/residence_features/services/residence_repository.dart';
import 'package:residence/features/residence_features/widget/RulesAndRegulationsWidget.dart';
import 'package:residence/features/residence_features/widget/additional_person_widget.dart';
import 'package:residence/features/residence_features/widget/comment_detail_widget.dart';
import 'package:residence/features/residence_features/widget/flutter_map_widget.dart';
import 'package:residence/features/residence_features/widget/reservation_btn_widget.dart';
import 'package:residence/features/residence_features/widget/residence_address_widget.dart';
import 'package:residence/features/residence_features/widget/residence_date_picker.dart';
import 'package:residence/route/names.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/string.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/widget/error_screen_widget.dart';
import '../logic/cubit/residence_cubit.dart';
import '../model/residence_detail_model.dart';
import '../widget/custom_detail_widget.dart';
import '../widget/residence_carousel_widget.dart';
import '../widget/residence_option.dart';

class ResidenceDetailScreen extends StatelessWidget {
  ResidenceDetailScreen({super.key});

  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    //!id
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
        create: (context) => ResidenceBloc(ResidenceDetailRepository())
          ..add(CallResidenceEvent(
              id: arguments['residence_detail_id'].toString())),
        child: BlocBuilder<ResidenceBloc, ResidenceState>(
          builder: (context, state) {
            if (state is ResidenceLoadingState) {
              return const Center(
                  child: SpinKitFadingCube(
                color: primaryColor,
                size: 40.0,
              ));
            }

            if (state is ResidenceCompletedSate) {
              ResidenceDetailModel helperDetail = state.residenceModel;
              return Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: BlocProvider(
                      create: (context) => ResidenceCubit(),
                      child: BlocBuilder<ResidenceCubit, int>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //!CarouselSlider
                              ResidenceCarouselSlider(
                                helperDetail: helperDetail,
                                carouselController: carouselController,
                                argumentId:
                                    arguments['residence_detail_id'].toString(),
                                favoriteStatus: helperDetail.fav!,
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              //!Info person
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 12.sp),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: getAllWidth(context),
                                      child: Column(
                                        children: [
                                          Text(
                                            helperDetail.title!,
                                            style: TextStyle(
                                                fontFamily: 'bold',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp),
                                          ),
                                          SizedBox(
                                            height: 8.sp,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Entypo.location_pin,
                                                color: primaryColor,
                                              ),
                                              Text(
                                                '${helperDetail.province}،${helperDetail.city}',
                                                style: TextStyle(
                                                    fontFamily: 'medium',
                                                    color: greyTxtColor),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.sp,
                                          ),
                                          helperDetail.discountPercentage == 0
                                              ? const SizedBox.shrink()
                                              : Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp,
                                                      vertical: 2.5.sp),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        getBorderRadiusFunc(
                                                            8.sp),
                                                  ),
                                                  child: Text(
                                                    '${helperDetail.discountPercentage} درصد تخفیف',
                                                    style: const TextStyle(
                                                        fontFamily: 'medium',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.sp,
                                    ),
                                    onDivider(),
                                    SizedBox(
                                      width: getAllWidth(context),
                                      height: getWidth(context, 0.20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                helperDetail.category!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp),
                                              ),
                                              SizedBox(
                                                height: 2.5.sp,
                                              ),
                                              Text(
                                                'به میزبانی ${helperDetail.user!.firstName} ${helperDetail.user!.lastName}',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily: 'medium'),
                                              )
                                            ],
                                          ),
                                          //!Profile
                                          Container(
                                            width: 55,
                                            height: 55,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(width: 1.5),
                                                color: Colors.white),
                                            child: ClipRRect(
                                                borderRadius:
                                                    getBorderRadiusFunc(1000),
                                                child: helperDetail.user ==
                                                        'null'
                                                    ? SvgPicture.asset(
                                                        'assets/icons/profile.svg',
                                                        width: 55,
                                                        height: 55,
                                                        fit: BoxFit.contain,
                                                      )
                                                    : CachedNetworkImage(
                                                        placeholder: (context,
                                                                url) =>
                                                            SvgPicture.asset(
                                                          'assets/icons/profile.svg',
                                                          width: 55,
                                                          height: 55,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            SvgPicture.asset(
                                                          'assets/icons/profile.svg',
                                                          width: 55,
                                                          height: 55,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        imageUrl: helperDetail
                                                            .user!.picture!,
                                                        width: 55,
                                                        height: 55,
                                                        fit: BoxFit.cover,
                                                      )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onDivider(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    const CustomDetailWidget(
                                      iconData: MaterialCommunityIcons
                                          .star_three_points_outline,
                                      title: 'رزرو آنی و قعطی اقامتگاه',
                                      desc:
                                          'برای رزرو نهایی این اقامتگاه نیازی به تایید از سمت میزبان نخواهید داشت و رزرو شما قعطی خواهد بود.',
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    onDivider(),
                                    SizedBox(
                                      height: 8.sp,
                                    ),
                                    CustomDetailWidget(
                                        iconData: Feather.home,
                                        title: 'درباره اقامتگاه',
                                        desc: helperDetail.accommodationAbout!),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    CustomDetailWidget(
                                        iconData: MaterialCommunityIcons
                                            .star_three_points_outline,
                                        title: 'ظرفیت',
                                        desc:
                                            'ظرفیت پایه ${helperDetail.minimumCapacity} نفر حداکثر تا ${helperDetail.maximumCapacity}نفر '),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    CustomDetailWidget(
                                        iconData:
                                            MaterialCommunityIcons.home_group,
                                        title: 'تعداد اتاق',
                                        desc:
                                            '${helperDetail.roomCount!.toString()} اتاق'),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    onDivider(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    //!Additional charge per person

                                    AdditionalPersonWidget(
                                        helperDetail: helperDetail),

                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    onDivider(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    //!Descriptions
                                    ExpandableText(
                                      helperDetail.description!,
                                      textAlign: TextAlign.justify,
                                      expandText: 'بیشتر',
                                      maxLines: 3,
                                      collapseText: 'بستن',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'normal',
                                          fontSize: 12.sp),
                                      linkColor: Colors.red,
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    onDivider(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    SizedBox(
                                      width: getAllWidth(context),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'امکانات اقامتگاه',
                                            style: TextStyle(
                                                fontFamily: 'bold',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp),
                                          ),

                                          ResidenceOption(
                                              residenceDetailModel:
                                                  helperDetail),
                                          //!ResidenceDatePicker
                                          ResidenceDatePicker(
                                            helperDetail: helperDetail,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    onDivider(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    SizedBox(
                                      width: getAllWidth(context),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'موقعیت مکانی اقامتگاه',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'bold',
                                                fontSize: 14.sp),
                                          ),
                                          SizedBox(
                                            height: 15.sp,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  ScreenNames.mapScreen);
                                            },
                                            child: SizedBox(
                                              width: getAllWidth(context),
                                              height: 200,
                                              child: ClipRRect(
                                                borderRadius:
                                                    getBorderRadiusFunc(10.sp),
                                                child: AbsorbPointer(
                                                  absorbing: true,
                                                  child: FlutterMapWidget(
                                                    lat: helperDetail
                                                        .location!.latitude!,
                                                    long: helperDetail
                                                        .location!.longitude!,
                                                    initialZoom: 14.sp,
                                                    interAction: false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.sp,
                                          ),
                                          Text(
                                            'موقعیت مکانی دقیق اقامتگاه پس از رزرو کامل ارسال خواهد شد.',
                                            style: TextStyle(
                                                fontFamily: 'medium',
                                                fontSize: 10.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    onDivider(),
                                    SizedBox(
                                      height: 10.sp,
                                    ),

                                    //! residence place address
                                    ResidenceAddressWidget(
                                        helperDetail: helperDetail),

                                    //! Guesthouse Rules and Regulations
                                    RulesAndRegulationsWidget(
                                        helperDetail: helperDetail),
                                    SizedBox(
                                      height: 20.sp,
                                    ),
                                    //!Comment section
                                    CommentDetailWidget(
                                      helperDetail: helperDetail,
                                      accommodationId: int.parse(
                                          arguments['residence_detail_id']
                                              .toString()),
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  )),

                  //!elevated-button
                  ReservationBtnWidget(
                    helperDetail: helperDetail,
                  ),
                ],
              );
            }

            if (state is ResidenceErrorSate) {
              return ErrorScreenWidget(
                  errorMsg: state.error.toString(),
                  function: () {
                    BlocProvider.of<ResidenceBloc>(context).add(
                        CallResidenceEvent(
                            id: arguments['residence_detail_id'].toString()));
                  });
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    ));
  }

  //!onDivider
  Divider onDivider() => const Divider();
}
