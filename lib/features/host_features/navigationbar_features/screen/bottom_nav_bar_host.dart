import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence/features/host_features/dashboard_features/screen/dashboard_screen.dart';
import '../../../../const/theme/colors.dart';
import '../../../public_features/logic/bottom_nav_cubit.dart';
import '../../calender_features/screen/register_residence_user.dart';

class BottomNavBarHost extends StatelessWidget {
  BottomNavBarHost({super.key});

  final List<Widget> screenList = [
    const DashboardScreen(),
    const RegisterResidenceUser(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        var helper = BlocProvider.of<BottomNavCubit>(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgWhite,
            // رنگ پس‌زمینه نوار ناوبری
            selectedItemColor: primary2Color,
            // رنگ آیتم‌های انتخاب شده
            unselectedItemColor: Colors.grey.shade500,
            // رنگ آیتم‌های انتخاب نشده
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontFamily: 'bold'),
            unselectedLabelStyle: const TextStyle(fontFamily: 'bold'),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'داشبورد',
                activeIcon: Icon(Icons.dashboard),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month_outlined,
                ),
                label: 'تقویم',
                activeIcon: Icon(Icons.calendar_month),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_travel),
                label: 'مالی',
                activeIcon: Icon(Icons.card_travel_outlined),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts_outlined),
                label: 'اطلاعات من',
                activeIcon: Icon(Icons.manage_accounts),
              ),
            ],
            currentIndex: helper.screenIndex,
            onTap: (value) {
              helper.onTabScreen(value);
            },
          ),
          body: screenList.elementAt(helper.screenIndex),
        );
      },
    );
  }
}
