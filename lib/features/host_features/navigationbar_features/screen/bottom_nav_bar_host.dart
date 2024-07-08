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
    Container(),
    const RegisterResidenceUser(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        var helper = BlocProvider.of<BottomNavCubit>(context);
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: primary2Color,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: theme.iconTheme.color,
              selectedLabelStyle: const TextStyle(fontFamily: 'bold'),
              unselectedLabelStyle: const TextStyle(fontFamily: 'bold'),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  label: 'داشبورد',
                  activeIcon: Icon(Icons.dashboard),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.note_outlined),
                  label: 'رزرو ها',
                  activeIcon: Icon(Icons.note),
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
              ],
              currentIndex: helper.screenIndex,
              onTap: (value) {
                helper.onTabScreen(value);
              },
            ),
            body: screenList.elementAt(helper.screenIndex),
          ),
        );
      },
    );
  }
}
