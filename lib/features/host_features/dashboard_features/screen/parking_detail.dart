import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../const/shape/border_radius.dart';
import '../../../../const/shape/media_query.dart';
import '../../../../const/string.dart';
import '../../../../const/theme/colors.dart';
import '../../../../route/names.dart';
import '../widget/app_bar_host.dart';
import '../widget/host_textfield.dart';
import '../widget/host_textfield_multiline.dart';

class ParkingDetail extends StatefulWidget {
  const ParkingDetail({super.key});

  @override
  State<ParkingDetail> createState() => _ParkingDetailState();
}

class _ParkingDetailState extends State<ParkingDetail> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _capacityParkingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form

  bool _hasShade = false;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _capacityParkingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarHost(title: 'مشخصات پارکینگ'),
        body: Container(
          width: getAllWidth(context),
          padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.03)),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Assigning _formKey to the Form widget
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نام پارکینگ',
                    style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  HostInputTextFieldWidget(
                    hintText: 'مانند: پارکینگ تهران پارس',
                    textInputAction: TextInputAction.next,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _titleController,
                    maxLength: 8,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    'توضیحات پارکینگ',
                    style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  HostTextFormFieldMultiLine(
                      minLine: 3,
                      maxLine: 6,
                      maxLength: 60,
                      hintText: 'در این قسمت پارکینگ خود را کامل شرح دهید.',
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.multiline,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      controller: _descriptionController,
                      icon: const Icon(Icons.edit_outlined)),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    'ظرفیت پارکینگ',
                    style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  HostInputTextFieldWidget(
                    hintText: 'مانند: 2 ظرفیت',
                    textInputAction: TextInputAction.next,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _capacityParkingController,
                    maxLength: 2,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),

                  Text(
                    'قیمت',
                    style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  HostInputTextFieldWidget(
                    hintText: 'مانند: 20000 تومان',
                    textInputAction: TextInputAction.next,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _priceController,
                    maxLength: 8,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'سایه‌بان:',
                        style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: _hasShade,
                            activeColor: primary2Color,
                            onChanged: (bool? value) {
                              setState(() {
                                _hasShade = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'دارد',
                            style: TextStyle(
                                fontFamily: 'normal', fontSize: 12.sp),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                            value: false,
                            groupValue: _hasShade,
                            activeColor: primary2Color,
                            onChanged: (bool? value) {
                              setState(() {
                                _hasShade = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'ندارد',
                            style: TextStyle(
                                fontFamily: 'normal', fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //!ElevatedButton Submit
                  const Divider(),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Center(
                    child: ElevatedButton(
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
                        if (_formKey.currentState!.validate()) {
                          KeySendDataHost.titleParking = _titleController.text;

                          KeySendDataHost.descriptionParking =
                              _descriptionController.text;

                          KeySendDataHost.capacityParking =
                              int.parse(_capacityParkingController.text);

                          KeySendDataHost.priceParking =
                              int.parse(_priceController.text);

                          KeySendDataHost.isCheckedParking = _hasShade;

                          Navigator.pushNamed(
                              context, ScreenNames.addressParkingScreen,
                              arguments: {
                                'parking_id': arguments['parking_id']
                              });

                          _titleController.clear();
                          _descriptionController.clear();
                          _capacityParkingController.clear();
                          _priceController.clear();
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
                    ),
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
