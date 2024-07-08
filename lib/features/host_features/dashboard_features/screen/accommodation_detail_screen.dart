import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:residence/const/shape/border_radius.dart';
import 'package:residence/const/theme/colors.dart';
import 'package:residence/route/names.dart';
import '../../../../const/shape/media_query.dart';
import '../../../../const/string.dart';
import '../model/host_model.dart';
import '../widget/app_bar_host.dart';
import '../widget/host_textfield.dart';
import '../widget/host_textfield_multiline.dart';

class AccommodationDetailScreen extends StatefulWidget {
  const AccommodationDetailScreen({super.key});

  @override
  State<AccommodationDetailScreen> createState() =>
      _AccommodationDetailScreenState();
}

class _AccommodationDetailScreenState extends State<AccommodationDetailScreen> {
  final TextEditingController _residenceName = TextEditingController();
  final TextEditingController _residenceDescription = TextEditingController();
  final TextEditingController _residenceAddress = TextEditingController();
  final TextEditingController _residenceAdditionalInfo =
      TextEditingController();
  final TextEditingController _residenceRoomCount = TextEditingController();
  final TextEditingController _residenceMinimumCapacity =
      TextEditingController();
  final TextEditingController _residenceMaximumCapacity =
      TextEditingController();
  final TextEditingController _residencePrice = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _residenceName.dispose();
    _residenceDescription.dispose();
    _residenceAddress.dispose();
    _residenceAdditionalInfo.dispose();
    _residenceRoomCount.dispose();
    _residenceMinimumCapacity.dispose();
    _residenceMaximumCapacity.dispose();
    _residencePrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //final HostModel hostModel = arguments['data_id'] as HostModel;

    // print(arguments['data_id'].toString());
    // print(hostModel.regulations!.length);
    return Scaffold(
      appBar: const AppBarHost(title: 'مشخصات اقامتگاه'),
      body: Container(
        width: getAllWidth(context),
        padding: EdgeInsets.symmetric(horizontal: getWidth(context, 0.03)),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.sp,
                ),
                Text(
                  'اقامتگاه خود را توصیف و اطلاعات آن را ثبت کنید.',
                  style: TextStyle(fontFamily: 'bold', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Text(
                  'نام اقامتگاه',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  'برای انتخاب نام از کلمات کوتاه و متناسب فضای اقامتگاه استفاده کنید. ',
                  style: TextStyle(
                    fontFamily: 'medium',
                    fontSize: 12.sp,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                HostInputTextFieldWidget(
                  hintText: 'مانند: اقامتگاه بومگردی خورشید',
                  textInputAction: TextInputAction.next,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  controller: _residenceName,
                  maxLength: 20,
                  textInputType: TextInputType.name,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'شرح کامل اقامتگاه',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                HostTextFormFieldMultiLine(
                    minLine: 3,
                    maxLine: 6,
                    maxLength: 60,
                    hintText: 'در این قسمت اقامتگاه خود را کامل شرح دهید.',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.multiline,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _residenceDescription,
                    icon: const Icon(Icons.edit_outlined)),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'توضیحات اقامتگاه',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                HostTextFormFieldMultiLine(
                    minLine: 3,
                    maxLine: 6,
                    maxLength: 60,
                    hintText: 'تعداد پله ها و متراژ بنا',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.multiline,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _residenceAdditionalInfo,
                    icon: const Icon(Icons.edit_outlined)),
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
                    hintText: 'گناباد شهرک سعدی خیابان گلها 12',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.multiline,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    controller: _residenceAddress,
                    icon: const Icon(Icons.edit_outlined)),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'تعداد اتاق',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                HostInputTextFieldWidget(
                  hintText: 'مانند: 2 اتاق',
                  textInputAction: TextInputAction.next,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  controller: _residenceRoomCount,
                  maxLength: 2,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'ظرفیت پایه',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                HostInputTextFieldWidget(
                  hintText: 'ظرفیت پایه (نفر)',
                  textInputAction: TextInputAction.next,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  controller: _residenceMinimumCapacity,
                  maxLength: 2,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'حداکثر ظرفیت',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                HostInputTextFieldWidget(
                  hintText: 'حداکثر ظرفیت (نفر)',
                  textInputAction: TextInputAction.next,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  controller: _residenceMaximumCapacity,
                  maxLength: 2,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'قیمت هر نفر اضافه به ازای هر شب (تومان)',
                  style: TextStyle(fontFamily: 'medium', fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                HostInputTextFieldWidget(
                  hintText: '20000 تومان',
                  textInputAction: TextInputAction.next,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  controller: _residencePrice,
                  maxLength: 8,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 15.sp,
                ),
                const Divider(),
                SizedBox(
                  height: 15.sp,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary2Color,
                          shape: RoundedRectangleBorder(
                              borderRadius: getBorderRadiusFunc(20.sp)),
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(
                                context,
                                0.3,
                              ),
                              vertical: getWidth(context, 0.03))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          KeySendDataHost.residenceName =
                              _residenceName.text.trim();
                          KeySendDataHost.residenceDescription =
                              _residenceDescription.text.trim();
                          KeySendDataHost.residenceAdditionalInfo =
                              _residenceAdditionalInfo.text.trim();
                          KeySendDataHost.residenceAddress =
                              _residenceAddress.text.trim();
                          KeySendDataHost.residenceRoomCount =
                              int.parse(_residenceRoomCount.text.trim());
                          KeySendDataHost.residenceMaximumCapacity =
                              int.parse(_residenceMaximumCapacity.text.trim());
                          KeySendDataHost.residenceMinimumCapacity =
                              int.parse(_residenceMinimumCapacity.text.trim());
                          KeySendDataHost.residencePrice =
                              int.parse(_residencePrice.text.trim());
                          Navigator.pushNamed(
                              context, ScreenNames.regulationResidenceScreen,
                              arguments: {'data_id': arguments['data_id']});
                        }
                      },
                      child: Text(
                        "ثبت و ادامه",
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 14.sp,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
