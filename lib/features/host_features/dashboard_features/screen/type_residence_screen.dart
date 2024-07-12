import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/features/host_features/dashboard_features/logic/dashboard_bloc.dart';
import 'package:residence/features/host_features/dashboard_features/model/host_model.dart';
import 'package:residence/features/host_features/dashboard_features/services/dashboard_repository.dart';
import 'package:residence/features/host_features/dashboard_features/widget/app_bar_host.dart';
import 'package:residence/route/names.dart';
import '../../../../const/connection.dart';
import '../../../../const/string.dart';
import '../../../../const/theme/colors.dart';
import '../../../public_features/widget/error_screen_widget.dart';

class TypeResidenceScreen extends StatelessWidget {
  const TypeResidenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!AppBar
      appBar: const AppBarHost(title: 'نوع اقامتگاه'),
      //!Body
      body: BlocProvider(
        create: (context) =>
            DashboardBloc(DashboardRepository())..add(CallDashboard()),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoadingState) {
              return const Center(
                  child: SpinKitFadingCube(
                color: primaryColor,
                size: 40.0,
              ));
            }

            if (state is DashboardCompletedState) {
              HostModel helper = state.hostModel;
              return Container(
                width: getAllWidth(context),
                padding:
                    EdgeInsets.symmetric(horizontal: getWidth(context, 0.03)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'چه نوع اقامتگاهی دارید؟',
                      style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                        itemCount: helper.categories!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              //!NextPage
                              KeySendDataHost.residenceTypeId =
                                  helper.categories![index].id!;
                              Navigator.pushNamed(context,
                                  ScreenNames.accommodationDetailScreen,
                                  arguments: {'data_id': helper});
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ClipRRect(
                                    borderRadius: getBorderRadiusFunc(10.sp),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '$baseUrl${helper.categories![index].picture}',
                                      width: getAllWidth(context),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/logo.png',
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const SizedBox.shrink(),
                                      ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/images/logo.png',
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const SizedBox.shrink(),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: getAllWidth(context),
                                    child: Text(
                                      helper.categories![index].title!,
                                      style: TextStyle(
                                          fontFamily: 'medium',
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is DashboardErrorState) {
              return ErrorScreenWidget(
                  errorMsg: state.errorMessage.toString(),
                  function: () {
                    BlocProvider.of<DashboardBloc>(context)
                        .add(CallDashboard());
                  });
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
