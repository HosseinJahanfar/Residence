import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../const/theme/colors.dart';
import '../../favorite_features/screens/favorite_screen.dart';
import '../../home_features/screens/home_screen.dart';
import '../../information_features/screens/info_notlog_screen.dart';
import '../../reservation_features/screens/reservation_screen.dart';
import '../logic/bottom_nav_cubit.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final List<Widget> screenList = [
    const HomeScreen(),
    const FavoriteScreen(),
    const Reservation(),
    const InformationLogin(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        var helper = BlocProvider.of<BottomNavCubit>(context);
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: bgWhite,
              selectedItemColor: primary2Color,
              unselectedItemColor: Colors.grey.shade500,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontFamily: 'bold'),
              unselectedLabelStyle: const TextStyle(fontFamily: 'bold'),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'خانه',
                  activeIcon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  label: 'علاقه مندی ها',
                  activeIcon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.luggage_outlined,
                  ),
                  label: 'سفر های من',
                  activeIcon: Icon(Icons.luggage),
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
          ),
        );
      },
    );
  }
}
