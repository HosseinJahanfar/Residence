import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/host_features/calender_features/screen/register_parking.dart';
import 'package:residence/features/host_features/calender_features/screen/register_residence_user.dart';
import 'package:residence/features/host_features/calender_features/services/calender_api_services.dart';
import 'package:residence/features/host_features/calender_features/services/calender_repository.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({super.key});

  @override
  State<MainTabBar> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<MainTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'سفر های من',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'bold',
                fontSize: 14.sp),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: getWidth(context, 0.20)),
          height: getWidth(context, 0.1),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: getBorderRadiusFunc(5.sp),
          ),
          child: TabBar(
            labelColor: primary2Color,
            unselectedLabelColor: Colors.grey.shade600,
            padding: EdgeInsets.all(2.5.sp),
            dividerColor: Colors.transparent,
            overlayColor: const WidgetStatePropertyAll(
              Colors.transparent,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text(
                  'رزرو های فعلی',
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text('رزرو های قبلی',
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'bold',
                        fontWeight: FontWeight.bold)),
              ),
            ],
            controller: _tabController,
            isScrollable: false,
            indicator: BoxDecoration(
              color: Colors.white60,
              borderRadius: getBorderRadiusFunc(5),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: const [RegisterResidenceUser(), RegisterParking()],
          ),
        ),
      ],
    );
  }
}
