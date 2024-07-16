import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/features/host_features/calender_features/model/register_parking_user_model.dart';

import '../../../../const/theme/colors.dart';
import '../../../public_features/widget/error_screen_widget.dart';
import '../logic/register_residence_user_bloc.dart';
import '../services/calender_repository.dart';
import '../widget/sliver_register_parking_uesr_item.dart';
import '../widget/sliver_register_residence_user_item.dart';

class RegisterParking extends StatelessWidget {
  const RegisterParking({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterResidenceUserBloc(CalenderRepository())
        ..add(CallRegisterParkingUser()),
      child: BlocBuilder<RegisterResidenceUserBloc, RegisterResidenceUserState>(
        builder: (context, state) {
          if (state is RegisterParkingUserLoading) {
            return const Center(
                child: SpinKitFadingCube(
                  color: primaryColor,
                  size: 40.0,
                ));
          }
          if (state is RegisterParkingUserCompleted) {
            List<RegisterParkingUserModel> helper =
                state.registerParkingUserModel;
            return CustomScrollView(
              slivers: [
                //!create calendar
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 5.sp),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: helper.length,
                            (context, index) {
                          return SliverListRegisterParkingUserItem(
                              helper: helper, index: index);
                        },
                      )),
                )
              ],
            );
          }
          if (state is RegisterParkingUserError) {
            return ErrorScreenWidget(
                errorMsg: state.errorMessage.toString(),
                function: () {
                  BlocProvider.of<RegisterResidenceUserBloc>(context)
                      .add(CallRegisterParkingUser());
                });
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
