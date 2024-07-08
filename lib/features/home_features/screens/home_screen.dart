import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/home_features/services/home_repository.dart';
import 'package:residence/features/home_features/widget/amazing.dart';
import 'package:residence/features/public_features/widget/error_screen_widget.dart';
import '../../../const/connection.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../public_features/functions/number_to_three.dart';
import '../logic/bloc/home_bloc.dart';
import '../model/home_model.dart';
import '../widget/carousel_widget.dart';
import '../widget/category_widget.dart';
import '../widget/parking_widget.dart';
import '../widget/residence_list_widget.dart';
import '../widget/shimmer_loading.dart';
import '../widget/sliver_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => HomeBloc(HomeRepository())..add(CallHomeEvent()),
      child: RefreshIndicator(
        color: primaryColor,
        onRefresh: () async {
          BlocProvider.of<HomeBloc>(context).add(CallHomeEvent());
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const ShimmerLoading();
            }
            if (state is HomeCompletedState) {
              HomeModel homeModel = state.homeModel;
              return CustomScrollView(
                slivers: [
                  SliverSearchBar(theme: theme),
                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                        Column(
                          children: [
                            //!CarouselSliderWidget
                            CarouselSliderWidget(homeModel: homeModel),
                            SizedBox(
                              height: 10.sp,
                            ),
                            //!grouping
                            CategoryWidgets(theme: theme),
                            SizedBox(
                              height: 8.sp,
                            ),
                            ResidenceList(
                              homeModel: homeModel.popularDestinations!,
                              title: 'محبوب ترین مقصد ها',
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            //!category City
                            ResidenceList(
                              homeModel: homeModel.southAccommodations!,
                              title: 'اقامت در شهر های جنوبی',
                            ),

                            SizedBox(
                              height: 8.sp,
                            ),
                            //!AmazingWidget
                            AmazingWidget(homeModel: homeModel, theme: theme),
                            SizedBox(
                              height: 12.5.sp,
                            ),
                            ResidenceList(
                              homeModel: homeModel.northAccommodations!,
                              title: 'اقامت در شهر های شمالی',
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            ResidenceList(
                              homeModel: homeModel.pilgrimageAndTouristCities!,
                              title: 'شهرهای زیارتی و سیاحتی',
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            //!ParkingWidget
                            ParkingWidget(homeModel: homeModel),
                          ],
                        ),
                      ]))
                ],
              );
            }
            if (state is HomeErrorState) {
              return ErrorScreenWidget(
                  errorMsg: state.error.toString(),
                  function: () {
                    context.read<HomeBloc>().add(CallHomeEvent());
                  });
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

