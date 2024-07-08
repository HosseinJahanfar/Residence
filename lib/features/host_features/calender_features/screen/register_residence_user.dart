import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/features/host_features/calender_features/services/calender_api_services.dart';
import 'package:residence/features/host_features/calender_features/services/calender_repository.dart';
import '../../../../const/theme/colors.dart';
import '../../../public_features/widget/error_screen_widget.dart';
import '../logic/register_residence_user_bloc.dart';
import '../model/register_residence_user_model.dart';
import '../widget/sliver_register_residence_user_item.dart';

class RegisterResidenceUser extends StatelessWidget {
  const RegisterResidenceUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterResidenceUserBloc(CalenderRepository())
        ..add(CallRegisterResidenceUserEvent()),
      child: BlocBuilder<RegisterResidenceUserBloc, RegisterResidenceUserState>(
        builder: (context, state) {
          if (state is RegisterResidenceUserLoadingState) {
            return const Center(
                child: SpinKitFadingCube(
              color: primaryColor,
              size: 40.0,
            ));
          }
          if (state is RegisterResidenceUserCompletedState) {
            List<RegisterResidenceUserModel> helper =
                state.registerResidenceUser;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: getAllWidth(context),
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Text(
                      'تقویم',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'bold',
                          fontSize: 14.sp),
                    ),
                  ),
                ),
                //!create calendar

                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 5.sp),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: helper.length,
                    (context, index) {
                      return SliverListRegisterResidenceUserItem(
                          helper: helper, index: index);
                    },
                  )),
                )
              ],
            );
          }
          if (state is RegisterResidenceUserError) {
            return ErrorScreenWidget(
                errorMsg: state.errorMessage.toString(),
                function: () {
                  BlocProvider.of<RegisterResidenceUserBloc>(context)
                      .add(CallRegisterResidenceUserEvent());
                });
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

