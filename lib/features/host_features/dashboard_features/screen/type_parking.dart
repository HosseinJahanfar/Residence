import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/const/theme/colors.dart';
import '../../../../const/shape/border_radius.dart';
import '../../../../const/shape/media_query.dart';
import '../../../../const/string.dart';
import '../../../../route/names.dart';
import '../../../public_features/widget/error_screen_widget.dart';
import '../logic/dashboard_bloc.dart';
import '../model/host_model.dart';
import '../services/dashboard_repository.dart';
import '../widget/app_bar_host.dart';

class TypeParking extends StatelessWidget {
  TypeParking({super.key});

  List<String> nameParking = ['عمومی', 'خصوصی'];
  List<IconData> iconList = [Icons.garage_outlined, Icons.local_parking];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarHost(title: 'نوع پارکینگ'),
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
                        'چه نوع پارکینگی دارید؟',
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
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                KeySendDataHost.typeParking = index;
                                //!NextPage
                                Navigator.pushNamed(
                                    context, ScreenNames.parkingDetailScreen,
                                    arguments: {'parking_id': helper});
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: ClipRRect(
                                        borderRadius:
                                            getBorderRadiusFunc(10.sp),
                                        child: Container(
                                            width: getAllWidth(context),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                            ),
                                            child: Icon(
                                              iconList[index],
                                              size: 100,
                                              color: primary2Color,
                                            ))),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: getAllWidth(context),
                                      child: Text(
                                        nameParking[index],
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
        ));
  }
}
