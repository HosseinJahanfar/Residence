import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/features/comment_features/logic/comment_bloc.dart';
import 'package:residence/features/home_features/screens/home_screen.dart';
import 'package:residence/features/host_features/upload_features/logic/upload_image_bloc.dart';
import 'package:residence/features/information_features/screens/about_screen.dart';
import 'package:residence/features/intro_features/screens/splash_screen.dart';
import 'package:residence/features/profile_features/screens/profile_screen.dart';
import 'package:residence/features/public_features/functions/preload_svg.dart';
import 'package:residence/features/public_features/logic/token_check/token_check_cubit.dart';
import 'package:residence/features/residence_features/logic/residence_bloc.dart';
import 'package:residence/features/residence_features/screen/residence_detail_screen.dart';
import 'package:residence/features/residence_features/widget/persian_picker.dart';
import 'package:residence/features/residence_features/widget/residence_date_picker.dart';
import 'package:residence/features/residence_list_features/logic/residence_list_bloc.dart';
import 'package:residence/features/residence_list_features/model/residence_list_model.dart';
import 'package:residence/features/residence_list_features/screen/residence_list_screen.dart';
import 'package:residence/features/residence_list_features/services/residence_list_repository.dart';
import 'package:residence/route/names.dart';
import 'package:residence/route/routes.dart';
import 'const/theme/colors.dart';
import 'const/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/comment_features/services/comment_repository.dart';
import 'features/favorite_features/screens/favorite_screen.dart';
import 'features/home_features/logic/bloc/home_bloc.dart';
import 'features/home_features/services/home_repository.dart';
import 'features/host_features/calender_features/logic/send_date_picker_residence/send_date_picker_residence_bloc.dart';
import 'features/host_features/calender_features/services/calender_repository.dart';
import 'features/host_features/dashboard_features/logic/city_logic/city_bloc.dart';
import 'features/host_features/dashboard_features/services/dashboard_api_services.dart';
import 'features/host_features/dashboard_features/services/dashboard_repository.dart';
import 'features/information_features/screens/contact_support.dart';
import 'features/public_features/logic/bottom_nav_cubit.dart';
import 'features/public_features/screen/bottom_nav_bar.dart';
import 'features/public_features/screen/unknownrout_screen.dart';
import 'features/residence_features/services/residence_repository.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: systemChrome,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: systemChrome,
      systemNavigationBarIconBrightness: Brightness.light));

  WidgetsFlutterBinding.ensureInitialized();
  await preloadSVGs(
    [
      'assets/icons/welcome.svg',
      'assets/icons/profile.svg',
      'assets/icons/questions.svg',
      'assets/icons/dashboard.svg'
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BottomNavCubit(),
            ),
            BlocProvider(
              create: (context) => TokenCheckCubit(),
            ),
            BlocProvider(
              create: (context) => CommentBloc(CommentRepository()),
            ),
            BlocProvider(
              create: (context) => ResidenceBloc(ResidenceDetailRepository()),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('fa')],
            title: 'rasidence',
            theme: CustomTheme.lightTheme,
            onUnknownRoute: (settings) => MaterialPageRoute(
              builder: (context) => const UnKnowRoutScreen(),
            ),
            initialRoute: ScreenNames.splashScreen,
            routes: routes,
            //  home: HostPersianDatePicker(),
          ),
        );
      },
    );
  }
}

//!SSL
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
