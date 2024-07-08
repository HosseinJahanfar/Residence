import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/shape/media_query.dart';
import 'package:residence/features/host_features/dashboard_features/services/dashboard_repository.dart';
import 'package:residence/features/host_features/upload_features/logic/upload_image_bloc.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import '../../../../const/string.dart';
import '../../../../const/theme/colors.dart';
import '../../dashboard_features/logic/residence_registration_bloc/residence_registration_bloc.dart';
import '../../dashboard_features/widget/app_bar_host.dart';

class UploadImageScreen extends StatelessWidget {
  const UploadImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadImageBloc = BlocProvider.of<UploadImageBloc>(context);
    return Scaffold(
      appBar: const AppBarHost(title: 'انتخاب تصویر'),
      body: SingleChildScrollView(
        child: Container(
          width: getAllWidth(context),
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.sp,
              ),
              Text(
                'لطفا تصاویر اقامتگاه خود را انتخاب و بارگذاری کنید.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'bold',
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              BlocBuilder<UploadImageBloc, UploadImageState>(
                builder: (context, state) {
                  if (state.images != null && state.images!.isNotEmpty) {
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.sp, vertical: 15.sp),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.sp,
                        mainAxisSpacing: 10.sp,
                      ),
                      itemCount: state.images!.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.images!.length) {
                          return GestureDetector(
                            onTap: () async {
                              final ImagePicker _picker = ImagePicker();
                              final List<XFile>? images =
                                  await _picker.pickMultiImage();
                              if (images != null) {
                                uploadImageBloc
                                    .add(OnSelectMultipleImageEvent(images));
                              }
                              print("====================");
                              KeySendDataHost.imageList.clear();
                              for (var element in images!) {
                                KeySendDataHost.imageList.add(element.path);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: getBorderRadiusFunc(10.sp),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 50.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return ClipRRect(
                            borderRadius: getBorderRadiusFunc(10.sp),
                            child: Image.file(
                              File(state.images![index].path),
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return InkWell(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        final List<XFile>? images =
                            await _picker.pickMultiImage();
                        if (images != null) {
                          uploadImageBloc
                              .add(OnSelectMultipleImageEvent(images));
                        }
                        KeySendDataHost.imageList.clear();
                        for (var element in images!) {
                          KeySendDataHost.imageList.add(element.path);
                        }
                        // print("====================");
                        // print(images);
                        // print(_picker);
                      },
                      child: Container(
                        width: getAllWidth(context),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: getBorderRadiusFunc(5.sp),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: getWidth(context, 0.05)),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.photo_camera,
                              size: 80,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text(
                              'بارگذاری تصاویر اقامتگاه',
                              style: TextStyle(
                                  fontFamily: 'bold', fontSize: 14.sp),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            const Text(
                              'لطفا تصویر مربوط به اقامتگاه خود را بارگذاری کنید',
                              style: TextStyle(fontFamily: 'medium'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20.sp), // Add spacing before the button
              Center(
                child: BlocProvider(
                  create: (context) =>
                      ResidenceRegistrationBloc(DashboardRepository()),
                  child: BlocConsumer<ResidenceRegistrationBloc,
                      ResidenceRegistrationState>(
                    listener: (context, state) {
                      if (state is ResidenceRegistrationCompletedState) {
                        getSnackBarWidget(context, state.success, Colors.green);
                      }
                      if (state is ResidenceRegistrationErrorState) {
                        getSnackBarWidget(
                          context,
                          state.errorMessage.toString(),
                          Colors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ResidenceRegistrationLoadingState) {
                        return const Center(
                            child: SpinKitFadingCube(
                          color: primaryColor,
                          size: 35.0,
                        ));
                      }

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary2Color,
                          shape: RoundedRectangleBorder(
                            borderRadius: getBorderRadiusFunc(20.sp),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 0.3),
                            vertical: getWidth(context, 0.03),
                          ),
                        ),
                        onPressed: () {
                          final currentState = uploadImageBloc.state;
                          if (currentState.images == null ||
                              currentState.images!.isEmpty) {
                            getSnackBarWidget(
                                context,
                                'لطفا حداقل یه عکس بارگزاری نمایید.',
                                Colors.red);
                          } else {
                            // Functionality for upload button
                            BlocProvider.of<ResidenceRegistrationBloc>(context)
                                .add(CallResidenceRegistration(
                                    category: KeySendDataHost.residenceTypeId,
                                    title: KeySendDataHost.residenceName,
                                    description:
                                        KeySendDataHost.residenceDescription,
                                    roomCount:
                                        KeySendDataHost.residenceRoomCount,
                                    minimumCapacity: KeySendDataHost
                                        .residenceMinimumCapacity,
                                    maximumCapacity: KeySendDataHost
                                        .residenceMaximumCapacity,
                                    province: KeySendDataHost.province,
                                    city: KeySendDataHost.city,
                                    address: KeySendDataHost.residenceAddress,
                                    accommodationAbout:
                                        KeySendDataHost.residenceAdditionalInfo,
                                    options: KeySendDataHost.options,
                                    checkInTime: KeySendDataHost.checkInTime,
                                    checkOutTime: KeySendDataHost.checkOutTime,
                                    regulations: KeySendDataHost.regulations,
                                    lat: KeySendDataHost.lat,
                                    long: KeySendDataHost.long,
                                    additionalPersonPrice:
                                        KeySendDataHost.residencePrice,
                                    imageList: KeySendDataHost.imageList));
                           // print(KeySendDataHost.imageList);
                            // print(KeySendDataHost.lat);
                            // print( KeySendDataHost.long);
                          }
                        },
                        child: Text(
                          'ثبت و ادامه',
                          style: TextStyle(fontSize: 14.sp, fontFamily: 'bold'),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
