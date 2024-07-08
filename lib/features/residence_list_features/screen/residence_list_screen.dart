import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/public_features/widget/error_screen_widget.dart';
import 'package:residence/features/residence_list_features/logic/residence_list_bloc.dart';
import 'package:residence/features/residence_list_features/services/residence_list_repository.dart';
import '../model/residence_list_model.dart';
import '../widget/item_residence_listview_widget.dart';
import '../widget/residence_search_bar.dart';

//!CallApiPageNext
class ChangeLoadingModel extends ValueNotifier {
  ChangeLoadingModel(super.value);

  Future<void> loadMoreVertical(BuildContext context, String resUrl) async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      BlocProvider.of<ResidenceListBloc>(context)
          .add(CallNextResidenceListEvent(strNextUrl: resUrl));
    });
  }
}

class ResidenceListScreen extends StatefulWidget {
  const ResidenceListScreen({super.key});

  @override
  State<ResidenceListScreen> createState() => _ResidenceListScreenState();
}

class _ResidenceListScreenState extends State<ResidenceListScreen> {
  final isLoad = ChangeLoadingModel(false);

  List<Accommodations> verticalData = [];

  bool isLoadingVertical = false;

  String result = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //!id
    // final Map<String, dynamic> arguments =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
        create: (context) => ResidenceListBloc(ResidenceListRepository())
          ..add(CallResidenceListEvent(id: 1.toString())),
        child: BlocBuilder<ResidenceListBloc, ResidenceListState>(
          builder: (context, state) {
            //!Loading
            if (state is ResidenceListLoadingState) {
              return const Center(
                  child: SpinKitFadingCube(
                color: primaryColor,
                size: 40.0,
              ));
            }
            //!Completed
            if (state is ResidenceListCompletedSate) {
              ResidenceListModel residenceListModel =
                  state.residenceListModel.last;

              for (var accommodation
                  in state.residenceListModel.last.results?.accommodations ??
                      []) {
                verticalData.add(accommodation);
              }
              result = residenceListModel.next.toString();
              return LazyLoadScrollView(
                isLoading: false,
                onEndOfPage: () => result != 'null'
                    ? isLoad.loadMoreVertical(context, result)
                    : null,
                child: CustomScrollView(
                  slivers: [
                    //!ResidenceSearchBar
                    ResidenceSearchBar(
                      theme: theme,
                      residenceModel: residenceListModel,
                    ),

                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 0.03)),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Colors.grey.shade300,
                              height: 0.5,
                            ),
                            Text(
                              residenceListModel.results!.title!,
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Text(
                              '${residenceListModel.count.toString()} اقامتگاه',
                              style: TextStyle(
                                  fontSize: 10.sp, fontFamily: 'bold'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 0.03)),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var helper = verticalData[index];
                            return ItemResidenceListView(helper: helper);
                          },
                          childCount: verticalData.length,
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          result == 'null'
                              ? const SizedBox.shrink()
                              : const SpinKitThreeBounce(
                                  color: primaryColor,
                                  size: 25.0,
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            //!State Error
            if (state is ResidenceListErrorState) {
              return ErrorScreenWidget(
                  errorMsg: state.error.toString(),
                  function: () {
                    BlocProvider.of<ResidenceListBloc>(context)
                        .add(CallResidenceListEvent(id: 1.toString()));
                  });
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    ));
  }
}
