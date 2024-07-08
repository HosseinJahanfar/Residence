import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/features/favorite_features/logic/favorite_bloc.dart';
import 'package:residence/features/favorite_features/services/favorite_repository.dart';
import 'package:residence/features/public_features/widget/error_screen_widget.dart';
import '../../../const/theme/colors.dart';
import '../model/favorite_model.dart';
import '../widget/sliver_list_favorite_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoriteBloc(FavoriteRepository())..add(CallFavoriteList()),
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoadingState) {
            return const Center(
                child: SpinKitFadingCube(
              color: primaryColor,
              size: 40.0,
            ));
          }
          if (state is FavoriteCompletedListState) {
            FavoriteModel helper = state.favoriteModel;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: getAllWidth(context),
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Text(
                      'علاقه مندی ها',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'bold',
                          fontSize: 14.sp),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 5.sp),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: helper.allFavorite!.length,
                    (context, index) {
                      AllFavorite helperIndex = helper.allFavorite![index];
                      return SliverListFavoriteItem(helperIndex: helperIndex);
                    },
                  )),
                )
              ],
            );
          }
          if (state is FavoriteErrorState) {
            return ErrorScreenWidget(
                errorMsg: state.errorMessage.toString(),
                function: () {
                  BlocProvider.of<FavoriteBloc>(context)
                      .add(CallFavoriteList());
                });
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
