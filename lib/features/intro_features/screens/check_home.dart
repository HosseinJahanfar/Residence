import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residence/features/authentication_features/screens/auth_screen.dart';
import 'package:residence/features/public_features/logic/token_check/token_check_cubit.dart';
import 'package:residence/features/public_features/screen/bottom_nav_bar.dart';

class CheckHome extends StatelessWidget {
  const CheckHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TokenCheckCubit, TokenCheckState>(
      builder: (context, state) {
        if (state is TokenCheckIsLog) {
          return BottomNavBar();
        } else {
          return const AuthScreen();
        }
      },
    ));
  }
}
