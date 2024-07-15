import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../const/shape/border_radius.dart';
import '../../../../const/shape/media_query.dart';
import '../../../../const/string.dart';
import '../../../../const/theme/colors.dart';
import '../../../../route/names.dart';
import '../../../public_features/widget/error_screen_widget.dart';
import '../../../public_features/widget/snack_bar.dart';
import '../logic/city_logic/city_bloc.dart';
import '../model/city_model.dart';
import '../model/host_model.dart';
import '../widget/app_bar_host.dart';
import '../widget/host_textfield_multiline.dart';

class AddressParking extends StatefulWidget {
  const AddressParking({super.key});

  @override
  State<AddressParking> createState() => _AddressParkingState();
}

class _AddressParkingState extends State<AddressParking> {
  String? dropDownValueProvinces;
  String? dropDownValueCity;
  String locationCity = '';
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form
  final TextEditingController _addressController = TextEditingController();
  int? selectedProvinceId;
  int? selectedCityId;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final HostModel hostModel = arguments['parking_id'] as HostModel;
    final Map<String, int> provincesMap = {
      for (var province in hostModel.provinces!) province.name!: province.id!
    };
    dropDownValueProvinces ??= null; // هیچ استانی انتخاب نشده باشد
    return Scaffold(
      appBar: const AppBarHost(title: 'آدرس پارکینگ'),
      body: Container(
        width: getAllWidth(context),
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.03)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey, // Assigning _formKey to the Form widget
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.sp),
                    Text(
                      'استان',
                      style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.sp),
                    Container(
                      width: getAllWidth(context),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropDownValueProvinces,
                          hint: const Text(
                            'انتخاب استان',
                            style: TextStyle(fontFamily: 'medium'),
                          ),
                          borderRadius: getBorderRadiusFunc(5.sp),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          menuMaxHeight: getWidth(context, 0.8),
                          items: [
                            DropdownMenuItem<String>(
                              value: null,
                              child: Text(
                                'انتخاب استان',
                                style: TextStyle(
                                  fontFamily: 'medium',
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            ...hostModel.provinces!.map((province) {
                              return DropdownMenuItem<String>(
                                value: province.name,
                                child: Text(province.name!),
                              );
                            }).toList(),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValueProvinces = newValue;
                              dropDownValueCity = null; // ریست کردن شهر
                              selectedProvinceId = provincesMap[newValue];
                            });
                            final selectedId = provincesMap[newValue];
                            // print(
                            //     'Selected Province Name: $newValue, ID: $selectedId');
                            if (selectedId != null) {
                              context.read<CityBloc>().add(
                                  CallCityEvent(id: selectedId.toString()));
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      'شهر',
                      style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.sp),
                    BlocBuilder<CityBloc, CityState>(
                      builder: (context, state) {
                        if (state is CityLoadingState) {
                          return const Center(
                            child: SpinKitFadingCube(
                              color: primaryColor,
                              size: 30.0,
                            ),
                          );
                        }
                        if (state is CityCompletedState) {
                          final List<CityModel> cities = state.cityList;
                          final List<DropdownMenuItem<String>> dropdownItems = [
                            DropdownMenuItem<String>(
                              value: null,
                              child: Text(
                                'انتخاب شهر',
                                style: TextStyle(
                                  fontFamily: 'medium',
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            ...cities.map((city) {
                              return DropdownMenuItem<String>(
                                value: city.id.toString(),
                                child: Text(city.name),
                              );
                            }).toList(),
                          ];

                          return Container(
                            width: getAllWidth(context),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropDownValueCity,
                                hint: const Text('انتخاب شهر'),
                                borderRadius: getBorderRadiusFunc(5.sp),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                menuMaxHeight: getWidth(context, 0.8),
                                items: dropdownItems,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropDownValueCity = newValue;
                                    selectedCityId =
                                        int.tryParse(newValue ?? '');
                                  });
                                  final selectedCity = cities.firstWhere(
                                    (city) => city.id.toString() == newValue,
                                    orElse: () =>
                                        CityModel(id: -1, name: "نامشخص"),
                                  );
                                  locationCity = selectedCity.name;
                                  // print('Selected City Name: ${selectedCity.name}');
                                },
                              ),
                            ),
                          );
                        }

                        if (state is CityErrorState) {
                          return ErrorScreenWidget(
                            errorMsg: state.errorMessage.toString(),
                            function: () {},
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      'آدرس',
                      style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    HostTextFormFieldMultiLine(
                        minLine: 3,
                        maxLine: 6,
                        maxLength: 60,
                        hintText:
                            'در این قسمت آدرس پارکینگ خود را کامل بنویسید.',
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.multiline,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        controller: _addressController,
                        icon: const Icon(Icons.edit_outlined)),
                  ],
                ),
                Column(
                  children: [
                    const Divider(),
                    SizedBox(height: 15.sp),
                    BlocConsumer<CityBloc, CityState>(
                      listener: (context, state) {
                        if (state is LocationCompletedState) {
                          var lat = state
                              .locationCityModel.items![0].location!.y
                              .toString();
                          var long = state
                              .locationCityModel.items![0].location!.x
                              .toString();
                          Navigator.pushNamed(
                            context,
                            ScreenNames.hostMapScreen,
                            arguments: {
                              'lat': lat,
                              'long': long,
                            },
                          );
                        }

                        if (state is LocationErrorState) {
                          getSnackBarWidget(
                            context,
                            state.errorMessage.toString(),
                            Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LocationLoadingState) {
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
                            if (dropDownValueProvinces == null ||
                                dropDownValueCity == null) {
                              getSnackBarWidget(
                                context,
                                'لطفاً استان، شهر و آدرس خود را بنویسید',
                                Colors.red,
                              );
                              return;
                            }

                            if (_formKey.currentState!.validate()) {
                              KeySendDataHost.provinceParking =
                                  selectedProvinceId!;
                              KeySendDataHost.cityParking = selectedCityId!;
                              KeySendDataHost.addressParking =
                                  _addressController.text;

                              context.read<CityBloc>().add(
                                    CallLocationCityEvent(
                                      cityName: locationCity,
                                    ),
                                  );
                            }
                          },
                          child: Text(
                            "ثبت و ادامه",
                            style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
