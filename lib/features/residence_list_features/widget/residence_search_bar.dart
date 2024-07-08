import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../model/residence_list_model.dart';

class ResidenceSearchBar extends StatelessWidget {
  const ResidenceSearchBar(
      {super.key, required this.theme, required this.residenceModel});

  final ThemeData theme;
  final ResidenceListModel residenceModel;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      forceElevated: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      toolbarHeight: Responsive.isTablet(context) ? 80 : 65,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      flexibleSpace: ResidenceSearchBarWidget(
        residenceListModel: residenceModel,
      ),
    );
  }
}

class ResidenceSearchBarWidget extends StatelessWidget {
  const ResidenceSearchBarWidget({
    super.key,
    required this.residenceListModel,
  });

  final ResidenceListModel residenceListModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getWidth(context, 0.05)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 0,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back))),
            SizedBox(
              width: 5.sp,
            ),
            Expanded(
              flex: 6,
              child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, SearchScreen.screenId);
                },
                child: Container(
                  height: Responsive.isTablet(context) ? 60 : 45,
                  decoration: BoxDecoration(
                    color: greyColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300]!,
                          blurRadius: 10,
                          spreadRadius: 1)
                    ],
                    borderRadius: getBorderRadiusFunc(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(getWidth(context, 0.03)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Feather.search,
                          color: greyTxtColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: getWidth(context, 0.02)),
                        Text(
                          'جستجوی اقامتگاه های ${residenceListModel.results!.title!}',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'normal',
                              fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
