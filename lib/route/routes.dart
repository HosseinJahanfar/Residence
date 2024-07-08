import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence/features/authentication_features/screens/auth_screen.dart';
import 'package:residence/features/host_features/dashboard_features/screen/host_map_screen.dart';
import 'package:residence/features/host_features/dashboard_features/screen/regulation_residence.dart';
import 'package:residence/features/information_features/screens/about_screen.dart';
import 'package:residence/features/intro_features/screens/check_home.dart';
import 'package:residence/features/profile_features/screens/profile_screen.dart';
import '../features/comment_features/screen/show_comment_screen.dart';
import '../features/home_features/screens/home_screen.dart';
import '../features/host_features/calender_features/screen/host_persian_date_picker.dart';
import '../features/host_features/dashboard_features/logic/city_logic/city_bloc.dart';
import '../features/host_features/dashboard_features/screen/accommodation_detail_screen.dart';
import '../features/host_features/dashboard_features/screen/address_residence.dart';
import '../features/host_features/dashboard_features/screen/type_residence_screen.dart';
import '../features/host_features/dashboard_features/services/dashboard_repository.dart';
import '../features/host_features/navigationbar_features/screen/bottom_nav_bar_host.dart';
import '../features/host_features/upload_features/logic/upload_image_bloc.dart';
import '../features/host_features/upload_features/screen/upload_image_screen.dart';
import '../features/information_features/screens/contact_support.dart';
import '../features/intro_features/screens/intro_screen.dart';
import '../features/intro_features/screens/splash_screen.dart';
import '../features/public_features/screen/bottom_nav_bar.dart';
import '../features/residence_features/screen/residence_detail_screen.dart';
import '../features/residence_features/widget/residence_map.dart';
import '../features/residence_list_features/screen/residence_list_screen.dart';
import 'names.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.splashScreen: (context) => const SplashScreen(),
  ScreenNames.introScreen: (context) => IntroScreen(),
  ScreenNames.homeScreen: (context) => const HomeScreen(),
  ScreenNames.checkHome: (context) => const CheckHome(),
  ScreenNames.bottomNavBarScreen: (context) => BottomNavBar(),
  ScreenNames.authScreen: (context) => const AuthScreen(),
  ScreenNames.contactSupport: (context) => const ContactSupport(),
  ScreenNames.aboutScreen: (context) => const AboutScreen(),
  ScreenNames.residenceDetailScreen: (context) => ResidenceDetailScreen(),
  ScreenNames.residenceListScreen: (context) => const ResidenceListScreen(),
  ScreenNames.profileScreen: (context) => const ProfileScreen(),
  ScreenNames.mapScreen: (context) => const ResidenceMap(),
  ScreenNames.showCommentScreen: (context) => const ShowCommentScreen(),
  ScreenNames.bottomNavBarHostScreen: (context) => BottomNavBarHost(),
  ScreenNames.typeResidenceScreen: (context) => const TypeResidenceScreen(),
  ScreenNames.accommodationDetailScreen: (context) =>
      const AccommodationDetailScreen(),
  ScreenNames.hostMapScreen: (context) => const HostMapScreen(),
  ScreenNames.regulationResidenceScreen: (context) =>
      const RegulationResidence(),
  ScreenNames.addressResidenceScreen: (context) => BlocProvider(
        create: (context) => CityBloc(DashboardRepository()),
        child: const AddressResidence(),
      ),
  ScreenNames.uploadImageScreen: (context) {
    return BlocProvider(
      create: (context) => UploadImageBloc(),
      child: const UploadImageScreen(),
    );
  },
  ScreenNames.hostPersianDatePickerScreen: (context) => const HostPersianDatePickerScreen(),

};
