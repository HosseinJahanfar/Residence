import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/features/host_features/dashboard_features/logic/city_logic/city_bloc.dart';
import 'package:residence/features/host_features/dashboard_features/model/host_model.dart';
import 'package:residence/features/public_features/widget/error_screen_widget.dart';
import 'package:residence/features/public_features/widget/snack_bar.dart';
import 'package:residence/route/names.dart';
import '../../../../const/shape/media_query.dart';
import '../../../../const/string.dart';
import '../model/city_model.dart';
import '../widget/app_bar_host.dart';

class AddressResidence extends StatefulWidget {
  const AddressResidence({super.key});

  @override
  State<AddressResidence> createState() => _AddressResidenceState();
}

class _AddressResidenceState extends State<AddressResidence> {
  String? dropDownValueProvinces;
  String? dropDownValueCity;
  final List<int> selectedIds = [];
  String locationCity = '';
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form
  int? selectedProvinceId;
  int? selectedCityId;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final HostModel hostModel = arguments['data_id'] as HostModel;

    dropDownValueProvinces ??= null; // هیچ استانی انتخاب نشده باشد

    final Map<String, int> provincesMap = {
      for (var province in hostModel.provinces!) province.name!: province.id!
    };

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarHost(title: 'آدرس اقامتگاه'),
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
                              print(
                                  'Selected Province Name: $newValue, ID: $selectedId');
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
                                      selectedCityId = int.tryParse(newValue ?? '');
                                    });
                                    final selectedCity = cities.firstWhere(
                                          (city) => city.id.toString() == newValue,
                                      orElse: () => CityModel(id: -1, name: "نامشخص"),
                                    );
                                    locationCity = selectedCity.name;
                                    print('Selected City Name: ${selectedCity.name}');
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
                      SizedBox(height: 10.sp),
                      Text(
                        'اپشن ها',
                        style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                      ),
                      ListView.builder(
                        itemCount: hostModel.options?.length ?? 0,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final option = hostModel.options?[index];
                          if (option == null) {
                            return const SizedBox.shrink();
                          }
                          return CheckboxListTile(
                            activeColor: primary2Color,
                            title: Text(option.name ?? "نامشخص"),
                            value: selectedIds.contains(option.id),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  selectedIds.add(option.id!);
                                } else {
                                  selectedIds.remove(option.id!);
                                }
                               // print("Selected ID: ${option.id}");
                              });
                            },
                          );
                        },
                      ),
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
                                  dropDownValueCity == null ||
                                  selectedIds.isEmpty) {
                                getSnackBarWidget(
                                  context,
                                  'لطفاً استان، شهر و حداقل یک گزینه را انتخاب کنید',
                                  Colors.red,
                                );
                                return;
                              }
      
                              if (_formKey.currentState!.validate()) {
                                // print('Selected Province ID: $selectedProvinceId');
                                // print('Selected City ID: $selectedCityId');
                                KeySendDataHost.province=selectedProvinceId!;
                                KeySendDataHost.city=selectedCityId!;
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
      ),
    );
  }
}
