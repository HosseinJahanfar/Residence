import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/profile_features/logic/bloc/image_bloc.dart';
import 'package:residence/features/profile_features/logic/cubit/image_cubit.dart';
import 'package:residence/features/profile_features/services/profile_repository.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';

import '../../../route/names.dart';
import '../../public_features/widget/text_field_widget.dart';
import '../widget/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  int sizeKB = 0;
  String imgPath='';

  @override
  void dispose() {
    super.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ProfileApiServices().callProfileApi('dada', 'dada', 'daada');
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            //!AppBar
            appBar: AppBar(
              title: Text(
                'اطلاعات حساب کاربری',
                style: TextStyle(
                    fontFamily: 'bold',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Container(
              width: getAllWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: BlocProvider(
                        create: (context) => ImageCubit(),
                        child: BlocBuilder<ImageCubit, ImageCubitState>(
                          builder: (context, state) {
                            if (state is ImageCubitInitial) {
                              return ImagePickerWidget(
                                textButton: 'انتخاب عکس پروفایل',
                                onFuncTab: () {
                                  context.read<ImageCubit>().pickImage();
                                },
                              );
                            } else if (state is ImageLoadedState) {
                              imgPath = state.imagePath;
                              //!SizePictures
                              int imageSizeInKB = state.imageSizeInKB;
                              // print('---------------');
                              // print(imgPath.toString());
                              sizeKB = imageSizeInKB;
                              return ImagePickerWidget(
                                textButton: 'انتخاب عکس پروفایل',
                                onFuncTab: () {
                                  BlocProvider.of<ImageCubit>(context)
                                      .pickImage();
                                },
                                isPic: true,
                                picPath: imgPath,
                              );
                            } else if (state is ImageErrorState) {
                              return ImagePickerWidget(
                                textButton: 'دوباره عکس خود را انتخاب کنید',
                                onFuncTab: () {
                                  BlocProvider.of<ImageCubit>(context).reset();
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      )),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      width: getAllWidth(context),
                      child: Form(
                        key: _globalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'نام',
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.bold,
                                  color: primary2Color),
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            InputTextFieldWidget(
                              hintText: 'نام خود را وارد نمایید',
                              textInputAction: TextInputAction.next,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              controller: _fNameController,
                              maxLength: 12, textInputType: TextInputType.name,
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            const Text('نام خانوادگی',
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontWeight: FontWeight.bold,
                                    color: primary2Color)),
                            SizedBox(
                              height: 5.sp,
                            ),
                            InputTextFieldWidget(
                              hintText: 'نام خانوادگی خود را وارد نمایید',
                              textInputAction: TextInputAction.done,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              controller: _lNameController,
                              maxLength: 12, textInputType: TextInputType.name,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 0,
                      child: SizedBox(
                        width: getAllWidth(context),
                        child: BlocProvider(
                          create: (context) => ImageBloc(ProfileRepository()),
                          child: BlocConsumer<ImageBloc, ProfileImageState>(
                            listener: (context, state) {
                              if (state is InfoErrorState) {
                                getSnackBarWidget(context, state.error.toString(), Colors.red);

                              }
                              if (state is InfoCompletedState) {
                                getSnackBarWidget(context, 'موفقیت امیز بود', Colors.green);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    ScreenNames.bottomNavBarScreen, (route) => false);
                              }
                            },
                            builder: (context, state) {
                              if (state is InfoLoadingState) {
                                return const Center(
                                    child: SpinKitFadingCube(
                                  color: primaryColor,
                                  size: 40.0,
                                ));
                              }
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primary2Color),
                                  onPressed: () {
                                    if (_globalKey.currentState!.validate()) {
                                      if (sizeKB < 200) {
                                        context.read<ImageBloc>().add(
                                            InfoSubmitRequest(
                                                firstName: _fNameController.text
                                                    .trim(),
                                                lastName: _lNameController.text
                                                    .trim(),
                                                fileImg: imgPath.trim().toString()));

                                      } else {
                                        getSnackBarWidget(
                                            context,
                                            'لطفا عکس کم حجم بارگذاری کنید!',
                                            Colors.red);
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'ثبت',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'bold',
                                    ),
                                  ));
                            },
                          ),
                        ),
                      )),
                ],
              ),
            )));
  }
}
